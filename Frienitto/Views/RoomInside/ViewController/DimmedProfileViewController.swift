//
//  DimmedProfileViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class DimmedProfileViewController: UIViewController {

    @IBOutlet var imageView: CircleImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            imageView.image = UIImage(named: "face\(user.imageCode)")
            nicknameLabel.text = user.username
            descriptionLabel.text = user.description
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
