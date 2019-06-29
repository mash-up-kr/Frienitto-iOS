//
//  CommonAlertViewController.swift
//  Frienitto
//
//  Created by mang on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class CommonAlertViewController: UIViewController {

    weak var delegate: PushViewControllerDelegate?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action

    @IBAction func confirmButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            guard let authCodeCheckViewController = UIStoryboard.instantiate(AuthCodeCheckViewController.self, name: "Login") as? AuthCodeCheckViewController else { return }
            authCodeCheckViewController.email = self.email
        self.delegate?.pushViewController(authCodeCheckViewController)
        })
    }
}
