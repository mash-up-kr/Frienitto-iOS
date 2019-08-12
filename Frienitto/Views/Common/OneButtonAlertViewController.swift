//
//  CommonAlertViewController.swift
//  Frienitto
//
//  Created by mang on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

protocol OneButtonAlertViewControllerDelegate: AnyObject {
    func oneButtonAlertViewController(_ viewConotroller: OneButtonAlertViewController, tapped button: UIButton)
}

class OneButtonAlertViewController: UIViewController {
    
    enum Status {
        case emailAuth
        case noEmail
        case registeredEmail
    }
    
    @IBOutlet private weak var firstLineLabel: UILabel!
    @IBOutlet private weak var secondLineLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    private var firstLineText: String?
    private var secondLineText: String?
    private var buttonText: String?
    
    weak var delegate: OneButtonAlertViewControllerDelegate?
    var status: Status = .emailAuth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func confirmButtonAction(_ sender: UIButton) {
        delegate?.oneButtonAlertViewController(self, tapped: sender)
    }
    
    func configure(status: Status) {
        switch status {
        case .emailAuth:
            configureEmailAuth()
        case .noEmail:
            configureNoEmail()
        case .registeredEmail:
            configureRegisteredEmail()
        }
    }
    
    private func configureEmailAuth() {
        firstLineText = "이메일로 인증번호가"
        secondLineText = "전달되었습니다."
        buttonText = "확인"
    }
    
    private func configureNoEmail() {
        firstLineText = "가입된 이메일이"
        secondLineText = "없습니다."
        buttonText = "다시 시도"
    }
    
    private func configureRegisteredEmail() {
        firstLineText = "이미 가입되어 있는"
        secondLineText = "이메일입니다."
        buttonText = "다른 이메일로 가입"
    }
    
    private func configureView() {
        firstLineLabel.text = firstLineText
        secondLineLabel.text = secondLineText
        button.setTitle(buttonText, for: .normal)
    }
}

extension OneButtonAlertViewControllerDelegate where Self: UIViewController {
    func oneButtonAlertViewController(_ viewConotroller: OneButtonAlertViewController, tapped button: UIButton) {
        dismiss(animated: true)
    }
}
