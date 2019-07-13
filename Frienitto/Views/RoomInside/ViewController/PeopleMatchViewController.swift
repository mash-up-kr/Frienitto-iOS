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
    @IBOutlet var matchingButton: UIButton!
    
    var users: [User] = []
    var roomName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchingButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension PeopleMatchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.cellIdentifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        let user = users[indexPath.item]
        cell.imageView.image = UIImage(named: "face\(user.imageCode)")
        cell.nameLabel.text = user.username
        cell.descriptionLabel.text = ""
        return cell
    }
}

extension PeopleMatchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dimmedViewController = UIStoryboard.instantiate(DimmedProfileViewController.self, name: "RoomInside") else { return }
        dimmedViewController.user = users[indexPath.item]
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
