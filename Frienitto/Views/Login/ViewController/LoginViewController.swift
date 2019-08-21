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
    @IBOutlet weak var warningEmailLabel: UILabel!
    @IBOutlet weak var warningPwLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Action
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if email.isEmpty || password.isEmpty {
            warningEmailLabel.isHidden = !email.isEmpty
            warningPwLabel.isHidden = !password.isEmpty
            return
        }
        
        warningEmailLabel.isHidden = true
        warningPwLabel.isHidden = true
        
        let provider = FrienttoProvider()
        
        showActivityIndicator()
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

            }, failure: { error, _ in
                guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
                alertViewController.delegate = self
                alertViewController.configure(status: .failureNetwork)
                
                self?.present(alertViewController, animated: true, completion: nil)
            })
            
        }, failure: { error, errorResponse in
            guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
            alertViewController.delegate = self
            alertViewController.configure(status: .noUser)
            
            self.present(alertViewController, animated: true, completion: nil)
        })
    }
    
    @IBAction func popViewController(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension LoginViewController: OneButtonAlertViewControllerDelegate { }
