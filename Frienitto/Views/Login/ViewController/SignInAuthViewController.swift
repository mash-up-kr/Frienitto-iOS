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
    
    private var status: EmailCodeStatus = .initial
    private var inputEmail: String?
    
    // MARK: - Private
    
    private func configure(_ status: EmailCodeStatus) {
        switch status {
        case .initial:
            self.status = .sent
            emailLabel.text = "이메일 인증 코드"
            textField.placeholder = "인증코드를 입력하십시오."
            textField.text = ""
            sendButton.setTitle("인증코드 재발송하기", for: .normal)
            confirmButton.isEnabled = true
            confirmButton.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.08235294118, blue: 0.3294117647, alpha: 1)
        case .sent:
            break
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Action
    
    @IBAction func sendAuthButton(_ sender: UIButton) {
        guard let email = textField.text, !email.isEmpty else { return }
        inputEmail = email
        
        showActivityIndicator()
        let provider = FrienttoProvider()

        provider.issueCode(receiverInfo: email, type: "EMAIL", completion: { [weak self] issueCodeModel in
            guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
            
            alertViewController.delegate = self
            alertViewController.configure(status: .emailAuth)
            
            self?.present(alertViewController, animated: true) {
                guard let self = self else { return }
                self.configure(self.status)
            }
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        guard let email = inputEmail, let code = textField.text else { return }
        
        showActivityIndicator()
        let provider = FrienttoProvider()
        
        provider.authCode(receiverInfo: email, type: "EMAIL", code: code, completion: { [weak self] authCodeModel in
            UserDefaults.standard.set(authCodeModel.data.registerToken, forKey: "registerToken")
            
            guard let signUpViewController = UIStoryboard.instantiate(SignUpViewController.self, name: "Login") else { return }
            signUpViewController.email = email
            
            self?.navigationController?.pushViewController(signUpViewController, animated: true)
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SignInAuthViewController: OneButtonAlertViewControllerDelegate { }
