//
//  PeopleListViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class PeopleListViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PeopleListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.cellIdentifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        return cell
    }
}

extension PeopleListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dimmedViewController = UIStoryboard.instantiate(DimmedProfileViewController.self, name: "RoomInside") as? DimmedProfileViewController else { return }
        present(dimmedViewController, animated: true, completion: nil)
    }
}

extension PeopleListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfRow: CGFloat = 2
        let space: CGFloat = 17
        let availableWidth = collectionView.frame.width - space
        let widthPerItem = availableWidth / numberOfRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
