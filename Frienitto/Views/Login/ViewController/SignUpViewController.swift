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
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    @IBOutlet weak var warningPwLabel: UILabel!
    @IBOutlet weak var warningConfirmPwLabel: UILabel!
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkedEmailLabel.text = email
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        guard let pw = passwordTextField.text,
            let confirmPw = passwordConfirmTextField.text else {
                warningPwLabel.isHidden = false
                return }
        
        if pw.isEmpty {
            warningPwLabel.isHidden = false
            warningConfirmPwLabel.isHidden = true
            return
        }
        
        if pw != confirmPw {
            warningPwLabel.isHidden = true
            warningConfirmPwLabel.isHidden = false
            return
        }
        
        warningPwLabel.isHidden = true
        warningConfirmPwLabel.isHidden = true
        
        guard let signUpCompleteViewController = UIStoryboard.instantiate(SignUpCompleteViewController.self, name: "Login") else { return }
        signUpCompleteViewController.email = email
        signUpCompleteViewController.password = passwordTextField.text
        
        navigationController?.pushViewController(signUpCompleteViewController, animated: true)
    }
}
