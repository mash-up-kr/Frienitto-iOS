//
//  MainListViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/11.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController {
    private enum ContentType: CaseIterable {
        case room
        case menu
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
    @IBOutlet private weak var userImageView: CircleImageView!
    
    var rooms: [Room] = []
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let user = user {
            userNameLabel.text = user.username
            userEmailLabel.text = user.email
            userImageView.image = UIImage(named: "face\(user.imageCode)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshRoomList()
    }
    
    @IBAction private func logOutButtonAction(_ sender: UIButton) {
        guard let alertViewController = UIStoryboard.instantiate(TwoButtonAlertViewController.self, name: "Login") else { return }
        alertViewController.delegate = self
        alertViewController.configure(status: .logout)
        present(alertViewController, animated: true)
    }
}

private extension MainListViewController {
    func refreshRoomList() {
        let provider = FrienttoProvider()
        showActivityIndicator()
        
        provider.retrieveRoomList(
            completion: { [weak self] roomListModel in
                self?.rooms = roomListModel.data
                self?.collectionView.reloadData()
            },
            failure: { error, errorResponse in
                print(error.localizedDescription)
            }
        )
    }
}

extension MainListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ContentType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = ContentType.allCases[section]
        switch section {
        case .room:
            return rooms.count
        case .menu:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = ContentType.allCases[indexPath.section]
        
        switch section {
        case .room:
            return configureMainRoomCell(collectionView, cellForItemAt: indexPath)
        case .menu:
            return configureMainMenuCell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    private func configureMainRoomCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainRoomCell.self)", for: indexPath) as? MainRoomCell else { return UICollectionViewCell() }
        cell.configure(room: rooms[indexPath.item])
        cell.delegate = self
        
        return cell
    }
    
    private func configureMainMenuCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainMenuCell.self)", for: indexPath) as? MainMenuCell else { return UICollectionViewCell() }
        cell.delegate = self
        
        return cell
    }
}

extension MainListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 244
        let height = collectionView.frame.height < 388 ? collectionView.frame.height : 388
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = ContentType.allCases[section]
        
        switch section {
        case .room:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case .menu:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
    }
}

extension MainListViewController: MainRoomCellDelegate {
    func mainRoomCell(_ cell: MainRoomCell, enteringRoomId id: Int) {
        let provider = FrienttoProvider()
        
        showActivityIndicator()
        provider.retrieveRoomDetail(id: id, completion: { [weak self] retrieveRoomDetailModel in
            guard let peopleMatchViewController = UIStoryboard.instantiate(PeopleMatchViewController.self, name: "RoomInside") else { return }
            peopleMatchViewController.room = retrieveRoomDetailModel.data
            
            self?.navigationController?.pushViewController(peopleMatchViewController, animated: true)
        }, failure: { error, _ in
            print(error.localizedDescription)
        })
    }
}

extension MainListViewController: MainMenuCellDelegate {
    func mainMenuCell(_ cell: MainMenuCell, tappedButton type: MainMenuCell.Button) {
        switch type {
        case .createRoom:
            guard let roomMakeViewController = UIStoryboard.instantiate(MakeRoomViewController.self, name: "MakeRoom") else { fatalError("MakeRoom error") }
            navigationController?.pushViewController(roomMakeViewController, animated: true)
        case .joinRoom:
            guard let roomInside = UIStoryboard.instantiate(RoomEnterViewController.self, name: "RoomInside") else { fatalError("RoomInside error") }
            navigationController?.pushViewController(roomInside, animated: true)
        }
    }
}

extension MainListViewController: TwoButtonAlertViewControllerDelegate { }
