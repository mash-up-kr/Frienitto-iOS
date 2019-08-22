//
//  PeopleMatchViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class PeopleMatchViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var roomNameLabel: UILabel!
    @IBOutlet private weak var numberOfPeopleLabel: UILabel!
    @IBOutlet private weak var matchingButton: UIButton!
    
    var room: Room! {
        didSet {
            if let participants = room.participants {
                self.participants = participants
            }
        }
    }
    var participants: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchingButton.isHidden = true
        roomNameLabel.text = room.title
        numberOfPeopleLabel.text = "\(participants.count)명이 입장했습니다."
        
        if let isOwner = room.isOwner {
            matchingButton.isHidden = isOwner
        }
    }
    
    @IBAction private func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func matchingButtonAction(_ sender: UIButton) {
        startMatching()
    }
}

private extension PeopleMatchViewController {
    func startMatching() {
        let provider = FrienttoProvider()
        showActivityIndicator()
        
        var user: User? = nil
        if let data = UserDefaults.standard.data(forKey: "userInfo") {
            user = try? JSONDecoder().decode(User.self, from: data)
        }
        
        provider.matchingStart(
            roomId: room.id,
            ownerId: user?.id ?? 0,
            completion: { [weak self] matchingStartModel in
                guard let selectViewController = UIStoryboard.instantiate(SelectViewController.self, name: "Select") else { return }
                let filteredMissions = matchingStartModel.data.missions.filter { $0.from.id == user?.id ?? 0 }
                
                selectViewController.mission = filteredMissions[0]
                selectViewController.room = self?.room
                
                self?.navigationController?.pushViewController(selectViewController, animated: true)
            },
            failure: { error, errorResponse in
                print(error.localizedDescription)
                print(errorResponse?.errorMessage)
            }
        )
    }
}

extension PeopleMatchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.cellIdentifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        let user = participants[indexPath.item]
        cell.imageView.image = UIImage(named: "face\(user.imageCode)")
        cell.nameLabel.text = user.username
        cell.descriptionLabel.text = user.description
        return cell
    }
}

extension PeopleMatchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dimmedViewController = UIStoryboard.instantiate(DimmedProfileViewController.self, name: "RoomInside") else { return }
        dimmedViewController.user = participants[indexPath.item]
        present(dimmedViewController, animated: true, completion: nil)
    }
}

extension PeopleMatchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfRow: CGFloat = 2
        let space: CGFloat = 17
        let availableWidth = collectionView.frame.width - space
        let widthPerItem = availableWidth / numberOfRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
