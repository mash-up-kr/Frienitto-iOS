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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        refreshRoomList()
        if user == nil {
            if let userInfo = UserDefaults.standard.object(forKey: "userInfo") as? Data {
                let decoder = JSONDecoder()
                if let loadedUser = try? decoder.decode(User.self, from: userInfo) {
                    user = loadedUser
                }
            }
        }
        
        if let user = user {
            userNameLabel.text = user.username
            userEmailLabel.text = user.email
            userImageView.image = UIImage(named: "face\(user.imageCode)")
        }
    }
    
    @IBAction private func logOutButtonAction(_ sender: UIButton) {
        guard let alertViewController = UIStoryboard.instantiate(TwoButtonAlertViewController.self, name: "Login") else { return }
        alertViewController.delegate = self
        alertViewController.configure(status: .logout)
        present(alertViewController, animated: true)
    }
}

private extension MainListViewController {
    func configureMainRoomCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainRoomCell.self)", for: indexPath) as? MainRoomCell else { return UICollectionViewCell() }
        cell.configure(room: rooms[indexPath.item])
        cell.delegate = self
        
        return cell
    }
    
    func configureMainMenuCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainMenuCell.self)", for: indexPath) as? MainMenuCell else { return UICollectionViewCell() }
        cell.delegate = self
        
        return cell
    }
    
    func retrieveRoomDetail(id: Int) {
        let provider = FrienttoProvider()
        showActivityIndicator()
        
        provider.retrieveRoomDetail(
            id: id,
            completion: { [weak self] retrieveRoomDetailModel in
                guard let peopleMatchViewController =
                    UIStoryboard.instantiate(PeopleMatchViewController.self, name: "RoomInside") else { return }
                peopleMatchViewController.room = retrieveRoomDetailModel.data
                
                self?.navigationController?.pushViewController(peopleMatchViewController, animated: true)
            },
            failure: { error, _ in
                print(error.localizedDescription)
            }
        )
    }
    
    func matchingInfo(room: Room, status: MainRoomCell.Status) {
        let provider = FrienttoProvider()
        showActivityIndicator()
        
        provider.matchingInfo(
            roomId: room.id,
            completion: { [weak self] matchingInfoModel in
                guard
                    let self = self,
                    let user = self.user else { return }
                
                if status == .matched {
                    let filteredMission = matchingInfoModel.data.filter { $0.from.id == user.id }

                    guard let selectViewController = UIStoryboard.instantiate(SelectViewController.self, name: "Select") else { return }
                    if !filteredMission.isEmpty {
                        selectViewController.mission = filteredMission[0]
                        selectViewController.room = room
                        
                        self.navigationController?.pushViewController(selectViewController, animated: true)
                    }else {
                        guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
                        
                        alertViewController.delegate = self
                        alertViewController.configure(status: .endMatching)
                        
                        self.present(alertViewController, animated: true)
                    }
                }

                if status == .expired {
                    let missions = matchingInfoModel.data
                    
                    guard let resultViewController = UIStoryboard.instantiate(ResultViewController.self, name: "Result") else { return }
                    resultViewController.missions = missions
                    
                    self.navigationController?.pushViewController(resultViewController, animated: true)
                }
            },
            failure: { error, errorResponse in
                print(error.localizedDescription)
            }
        )
    }
    
    func refreshRoomList() {
        let provider = FrienttoProvider()
        showActivityIndicator()
        
        provider.retrieveUserRoom(
            completion: { [weak self] roomListModel in
                self?.rooms = roomListModel.data
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
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
}

extension MainListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 260
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
    func mainRoomCell(_ cell: MainRoomCell, room: Room, status: MainRoomCell.Status) {
        switch status {
        case .created: retrieveRoomDetail(id: room.id)
        case .matched, .expired:
            matchingInfo(room: room, status: status)
        }
    }
}

extension MainListViewController: MainMenuCellDelegate {
    func mainMenuCell(_ cell: MainMenuCell, tappedButton type: MainMenuCell.Button) {
        switch type {
        case .createRoom:
            guard let roomMakeViewController = UIStoryboard.instantiate(MakeRoomViewController.self, name: "MakeRoom") else { fatalError("MakeRoom error") }
            present(roomMakeViewController, animated: true, completion: nil)
        case .joinRoom:
            guard let roomInside = UIStoryboard.instantiate(RoomEnterViewController.self, name: "RoomInside") else { fatalError("RoomInside error") }
            navigationController?.pushViewController(roomInside, animated: true)
        }
    }
}

extension MainListViewController: OneButtonAlertViewControllerDelegate, TwoButtonAlertViewControllerDelegate { }
