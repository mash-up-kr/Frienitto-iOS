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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PeopleMatchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.cellIdentifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        return cell
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
