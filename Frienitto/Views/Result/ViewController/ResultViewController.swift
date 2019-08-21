//
//  ResultViewController.swift
//  Frienitto
//
//  Created by jarvis on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var missions: [Mission] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mission = missions[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.cellIdentifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(from: mission.from, to: mission.to)
        
        return cell
    }
}

extension ResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 154
        return CGSize(width: width, height: height)
    }
}
