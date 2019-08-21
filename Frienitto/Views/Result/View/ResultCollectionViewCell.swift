//
//  ResultCollectionViewCell.swift
//  Frienitto
//
//  Created by jarvis on 24/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "resultCell"
    
    @IBOutlet private weak var fromImageView: UIImageView!
    @IBOutlet private weak var fromNameLabel: UILabel!
    @IBOutlet private weak var fromDescriptionLabel: UILabel!
    @IBOutlet private weak var toImageView: UIImageView!
    @IBOutlet private weak var toNameLabel: UILabel!
    @IBOutlet private weak var toDescriptionLabel: UILabel!
    
    func configure(from: User, to: User) {
        fromImageView.image = UIImage(named: "face\(from.imageCode)")
        fromNameLabel.text = from.username
        fromDescriptionLabel.text = from.description
        
        toImageView.image = UIImage(named: "face\(to.imageCode)")
        toNameLabel.text = to.username
        toDescriptionLabel.text = to.description
    }
}
