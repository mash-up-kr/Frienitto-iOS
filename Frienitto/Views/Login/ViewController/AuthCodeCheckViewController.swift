//
//  AuthCodeCheckViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class AuthCodeCheckViewController: UIViewController {
    @IBOutlet var authCodeTextField: UITextField!

    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        let provider = FrienttoProvider()
        guard let email = email, let code = authCodeTextField.text else { return }
        provider.authCode(receiverInfo: email, type: "EMAIL", code: code, completion: { response in
            let result = try? response?.map(AuthCodeModel.self)
            
            if let result = result {
                print(result.data.registerToken)
            }
            
            guard let signUpViewController = UIStoryboard.instantiate(SignUpViewController.self, name: "Login") as? SignUpViewController else { return }
            self.navigationController?.pushViewController(signUpViewController, animated: true)
            
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}
