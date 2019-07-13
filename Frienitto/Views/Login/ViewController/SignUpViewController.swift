//
//  SignUpViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var checkedEmailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkedEmailLabel.text = email
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        guard let signUpCompleteViewController = UIStoryboard.instantiate(SignUpCompleteViewController.self, name: "Login") else { return }
        signUpCompleteViewController.email = email
        signUpCompleteViewController.password = passwordTextField.text
        
        navigationController?.pushViewController(signUpCompleteViewController, animated: true)
    }
}
