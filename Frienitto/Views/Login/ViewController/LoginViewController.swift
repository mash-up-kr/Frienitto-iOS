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
    }

    // MARK: - Action
    
    @IBAction func loginButtonAction(_ sender: Any) {
        configureWarningLabels()
        
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty else { return }
        
        signIn(email: email, password: password)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

private extension LoginViewController {
    func configureWarningLabels() {
        warningEmailLabel.isHidden = !(emailTextField.text?.isEmpty ?? false)
        warningPwLabel.isHidden = !(passwordTextField.text?.isEmpty ?? false)
    }
    
    func signIn(email: String, password: String) {
        let provider = FrienttoProvider()
        showActivityIndicator()
        
        provider.signIn(
            email: email,
            password: password,
            completion: { [weak self] signInModel in
                UserDefaults.standard.set(signInModel.data.token, forKey: "authorizationToken")
                if let data = try? JSONEncoder().encode(signInModel.data.user) {
                    UserDefaults.standard.set(data, forKey: "userInfo")
                }
                
                self?.retrieveUserRoom(signInModel: signInModel)
                
            },
            failure: { [weak self] error, errorResponse in
                self?.presentAlertViewController(status: .noUser)
            }
        )
    }
    
    func retrieveUserRoom(signInModel: SignInModel) {
        let provider = FrienttoProvider()
        showActivityIndicator()
        
        provider.retrieveUserRoom(
            completion: { [weak self] roomListModel in
                guard let self = self else { return }
                
                let rooms = roomListModel.data
                let user = signInModel.data.user
                
                let nextViewController = self.getNextViewController(rooms: rooms, user: user)
            
                self.navigationController?.setViewControllers([nextViewController], animated: true)
            },
            failure: { [weak self] error, _ in
                self?.presentAlertViewController(status: .failureNetwork)
            }
        )
    }
    
    func getNextViewController(rooms: [Room], user: User) -> UIViewController {
        let nextViewController: UIViewController
        
        if rooms.isEmpty {
            nextViewController = self.getMainViewController()
        } else {
            nextViewController = self.getMainListViewController(rooms: rooms, user: user)
        }
        
        return nextViewController
    }
    
    func getMainViewController() -> UIViewController {
        guard let mainViewController = UIStoryboard.instantiate(MainViewController.self, name: "Main") else { return UIViewController() }
        return mainViewController
    }
    
    func getMainListViewController(rooms: [Room], user: User) -> UIViewController {
        guard let mainListViewController = UIStoryboard.instantiate(MainListViewController.self, name: "Main") else { return UIViewController() }
        
        mainListViewController.rooms = rooms
        mainListViewController.user = user
        
        return mainListViewController
    }
    
    func presentAlertViewController(status: OneButtonAlertViewController.Status) {
        guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
        alertViewController.delegate = self
        alertViewController.configure(status: status)
        
        present(alertViewController, animated: true, completion: nil)
    }
}

extension LoginViewController: OneButtonAlertViewControllerDelegate { }
