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

    // MARK: - IBOutlet
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Private
    
    private func sendAuthApi() {
        guard let email = emailTextField.text else { return }
        let provider = FrienttoProvider()
        provider.issueCode(receiverInfo: email, type: "EMAIL", completion: {[weak self] (response) in
            guard let ss = self else { return }
            do {
                let responseModel = try response?.map(IssueCodeModel.self)
                
                if responseModel?.code == 202 {
                    let alertVC = UIStoryboard.instantiate(CommonAlertViewController.self, name: "Login")
                    guard let vc = alertVC else { return }
                    vc.modalPresentationStyle = .overCurrentContext
                    self?.present(vc, animated: false, completion: {
                        ss.emailLabel.text = "이메일 인증 코드"
                        ss.emailTextField.placeholder = "인증코드를 입력하십시오."
                        ss.emailTextField.text = ""
                    })
                }
            }catch (let error){
                print(error.localizedDescription)
            }
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Action
    
    @IBAction func sendAuthButtonAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        if !email.isEmpty {
            sendAuthApi()
        }
    }
}
