//
//  LoginSignViewController.swift
//  Frienitto
//
//  Created by mang on 29/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class LoginSignViewController: UIViewController {

    // MARK: - Private
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        let loginVC = UIStoryboard.instantiate(LoginViewController.self, name: "Login")
        guard let vc = loginVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        let signVC = UIStoryboard.instantiate(SignInAuthViewController.self, name: "Login")
        guard let vc = signVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
