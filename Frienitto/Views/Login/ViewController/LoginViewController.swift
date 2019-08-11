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
            
            guard let mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController else { return }
            UIApplication.shared.keyWindow?.rootViewController = mainNavigationController
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func popViewController(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
