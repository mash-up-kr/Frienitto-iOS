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
    
    let dummies: [Room] = [
        Room(expiresDate: "2019-08-11", id: 1, isOwner: true, participants: [User(imageCode: 1, username: "hello", id: 1)], status: "xxx", title: "xxx xxxx  xxxxx xxx xx x x x x xx"),
        Room(expiresDate: "2019-08-14", id: 2, isOwner: true, participants: [User(imageCode: 1, username: "hello", id: 1)], status: "xxx", title: "xxx"),
        Room(expiresDate: "2019-08-15", id: 3, isOwner: true, participants: [User(imageCode: 1, username: "hello", id: 1)], status: "xxx", title: "xxx"),
        Room(expiresDate: "2019-08-16", id: 4, isOwner: true, participants: [User(imageCode: 1, username: "hello", id: 1)], status: "xxx", title: "xxx")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func logOutButtonAction(_ sender: Any) {
        guard let alertViewController = UIStoryboard.instantiate(TwoButtonAlertViewController.self, name: "Login") else { return }
        alertViewController.delegate = self
        alertViewController.configure(status: .logout)
        present(alertViewController, animated: true)
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
            return dummies.count
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
        cell.configure(room: dummies[indexPath.item])
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
