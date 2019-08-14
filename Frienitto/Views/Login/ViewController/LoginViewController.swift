//
//  LoginViewController.swift
//  Frienitto
//
//  Created by mang on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Action
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let provider = FrienttoProvider()
        provider.signIn(email: email, password: password, completion: { [weak self] signInModel in
            UserDefaults.standard.set(signInModel.data.token, forKey: "authorizationToken")
            if let data = try? JSONEncoder().encode(signInModel.data.user) {
                UserDefaults.standard.set(data, forKey: "userInfo")
            }
            
            provider.retrieveRoomList(completion: { [weak self] roomListModel in
                let nextViewController: UIViewController
                
                if roomListModel.data.isEmpty {
                    guard let mainViewController = UIStoryboard.instantiate(MainViewController.self, name: "Main") else { return }
                    nextViewController = mainViewController
                } else {
                    guard let mainListViewController = UIStoryboard.instantiate(MainListViewController.self, name: "Main") else { return }
                    
                    nextViewController = mainListViewController
                    mainListViewController.rooms = roomListModel.data
                    mainListViewController.user = signInModel.data.user
                }
                
                self?.navigationController?.setViewControllers([nextViewController], animated: true)

            }, failure: { error in
                print(error.localizedDescription)
            })
            
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func popViewController(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
