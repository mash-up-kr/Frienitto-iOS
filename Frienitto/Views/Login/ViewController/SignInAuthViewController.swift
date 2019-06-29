//
//  SignInAuthViewController.swift
//  Frienitto
//
//  Created by mang on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit
import Moya

protocol PushViewControllerDelegate: class {
    func pushViewController(_ viewController: UIViewController)
}

class SignInAuthViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    weak var delegate: PushViewControllerDelegate?
    
    // MARK: - Private
    
    private func sendAuthApi() {
        guard let email = emailTextField.text else { return }
        let provider = FrienttoProvider()
        provider.issueCode(receiverInfo: email, type: "EMAIL", completion: {[weak self] (response) in
            guard let self = self else { return }
            do {
                let responseModel = try response?.map(IssueCodeModel.self)
                
                if responseModel?.code == 202 {
                    guard let alertVC = UIStoryboard.instantiate(CommonAlertViewController.self, name: "Login") as? CommonAlertViewController else { return }
                    alertVC.modalPresentationStyle = .overCurrentContext
                    alertVC.email = email
                    alertVC.delegate = self
                    
                    self.present(alertVC, animated: false)
                }
            } catch (let error){
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
    
    @IBAction func sendAuthButtonAction(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        if !email.isEmpty {
            sendAuthApi()
        }
    }
}

extension SignInAuthViewController: PushViewControllerDelegate {
    func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
