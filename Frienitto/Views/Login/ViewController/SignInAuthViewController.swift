//
//  SignInAuthViewController.swift
//  Frienitto
//
//  Created by mang on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit
import Moya

class SignInAuthViewController: UIViewController {

    enum EmailCodeStatus {
        case initial
        case sent
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var warningEmailLabel: UILabel!
    
    private var status: EmailCodeStatus = .initial
    private var inputEmail: String = ""
    
    // MARK: - Private
    
    private func configure(_ status: EmailCodeStatus) {
        switch status {
        case .initial:
            self.status = .sent
            emailLabel.text = "이메일 인증 코드"
            textField.placeholder = "인증코드를 입력하십시오."
            textField.text = ""
            sendButton.setTitle("인증코드 재발송하기", for: .normal)
            warningEmailLabel.isHidden = true
            
        case .sent:
            break
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.isEnabled = false
    }

    // MARK: - Action
    
    @IBAction func sendAuthButton(_ sender: UIButton) {
        guard let email = textField.text, !email.isEmpty else {
            warningEmailLabel.isHidden = false
            return
        }
        
        if sendButton.currentTitle == "인증코드 발송하기" {
            inputEmail = email
        }
        
        showActivityIndicator()
        let provider = FrienttoProvider()

        provider.issueCode(receiverInfo: inputEmail, type: "EMAIL", completion: { [weak self] issueCodeModel in
            guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
            
            alertViewController.delegate = self
            alertViewController.configure(status: .emailAuth)
            
            self?.present(alertViewController, animated: true) {
                guard let self = self else { return }
                self.configure(self.status)
            }
        }, failure: { error, result in
            if result?.errorCode == 409 {
                guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
                
                alertViewController.delegate = self
                alertViewController.configure(status: .registeredEmail)
                
                self.present(alertViewController, animated: true)
            }
            print(error.localizedDescription)
        })
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        guard let code = textField.text else { return }
        
        showActivityIndicator()
        let provider = FrienttoProvider()
        
        provider.authCode(receiverInfo: inputEmail, type: "EMAIL", code: code, completion: { [weak self] authCodeModel in
            guard let ss = self else { return }
            UserDefaults.standard.set(authCodeModel.data.registerToken, forKey: "registerToken")
            
            guard let signUpViewController = UIStoryboard.instantiate(SignUpViewController.self, name: "Login") else { return }
            signUpViewController.email = ss.inputEmail
            
            ss.navigationController?.pushViewController(signUpViewController, animated: true)
        }, failure: { error, _ in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textFieldChanging(_ sender: Any) {
        guard let code = textField.text else { return }
        if emailLabel.text == "이메일 인증 코드" {
            if !code.isEmpty {
                confirmButton.isEnabled = true
                confirmButton.backgroundColor = UIColor(named: "darkIndigo")
            }else {
                confirmButton.isEnabled = false
                confirmButton.backgroundColor = UIColor(named: "darkgrey")
            }
        }
    }
}

extension SignInAuthViewController: OneButtonAlertViewControllerDelegate { }
