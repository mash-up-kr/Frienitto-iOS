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
        provider.signIn(email: email, password: password, completion: { response in
            let result = try? response?.map(SignInModel.self)
            
            if let result = result {
                UserDefaults.standard.set(result.data.token, forKey: "authorizationToken")
                UserDefaults.standard.set(email, forKey: "userEmail")
            }
            
//            provider.retrieveRoomList(completion: { response in
//                let result = try? response?.map(RoomListModel.self)
//
//                if let result = result {
//                    let nextViewController: UIViewController
//                    if result.data.count == 0 {
//                        guard let mainViewController = UIStoryboard.instantiate(MainViewController.self, name: "Main") else { return }
//                        nextViewController = mainViewController
//                    } else {
//                        guard let mainListViewController = UIStoryboard.instantiate(MainListViewController.self, name: "Main") else { return }
//                        nextViewController = mainListViewController
//                    }
//
//                    self.navigationController?.setViewControllers([nextViewController], animated: true)
//                }
//
//            }, failure: { error in
//                print(error.localizedDescription)
//            })
            
            guard let mainListViewController = UIStoryboard.instantiate(MainListViewController.self, name: "Main") else { return }
            self.navigationController?.setViewControllers([mainListViewController], animated: true)
            
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func popViewController(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
