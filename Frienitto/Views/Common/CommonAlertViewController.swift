//
//  CommonAlertViewController.swift
//  Frienitto
//
//  Created by mang on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class CommonAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action

    @IBAction func confirmButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
