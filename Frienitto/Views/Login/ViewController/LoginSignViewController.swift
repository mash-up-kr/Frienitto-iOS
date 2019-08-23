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
        
        allNaviGuesturePop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - Private
    
    private func allNaviGuesturePop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
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
