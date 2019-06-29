//
//  PeopleMatchViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class PeopleMatchViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var roomNameLabel: UILabel!
    @IBOutlet var numberOfPeopleLabel: UILabel!
    
    let dummyUsers: [User] = [User(imageCode: 1, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 2, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 3, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 4, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 5, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 6, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 1, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 2, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 3, name: "꿀꿀", description: "하하하"),
                              User(imageCode: 4, name: "꿀꿀", description: "하하하")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PeopleMatchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.cellIdentifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        let user = dummyUsers[indexPath.item]
        cell.imageView.image = UIImage(named: "face\(user.imageCode)")
        cell.nameLabel.text = user.name
        cell.descriptionLabel.text = user.description
        return cell
    }
}

extension PeopleMatchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dimmedViewController = UIStoryboard.instantiate(DimmedProfileViewController.self, name: "RoomInside") as? DimmedProfileViewController else { return }
        dimmedViewController.user = dummyUsers[indexPath.item]
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
