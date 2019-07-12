//
//  SignUpViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        guard let signUpCompleteViewController = UIStoryboard.instantiate(SignUpCompleteViewController.self, name: "Login") else { return }
        let email = emailTextField.text
        signUpCompleteViewController.email = email
        signUpCompleteViewController.password = passwordTextField.text
        
        navigationController?.pushViewController(signUpCompleteViewController, animated: true)
    }
}
