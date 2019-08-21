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
        case emptyEmail
        case noUser
        case failureNetwork
        
        var firstLineText: String {
            switch self {
            case .emailAuth:
                return "이메일로 인증번호가"
            case .noEmail:
                return "가입된 이메일이"
            case .registeredEmail:
                return "이미 가입되어 있는"
            case .emptyEmail:
                return "이메일을"
            case .noUser:
                return "찾을 수 없는 사용자 입니다."
            case .failureNetwork:
                return "네트워크 상태가 원활하지 않습니다."
            }
        }
        var secondLineText: String {
            switch self {
            case .emailAuth:
                return "전달되었습니다."
            case .noEmail:
                return "없습니다."
            case .registeredEmail:
                return "이메일입니다."
            case .emptyEmail:
                return "입혁해주세요."
            case .noUser:
                return "다시 입력해주세요."
            case .failureNetwork:
                return "다시 시도해주세요."
            }
        }
        var buttonText: String {
            switch self {
            case .emailAuth:
                return "확인"
            case .noEmail:
                return "다시 시도"
            case .registeredEmail:
                return "다른 이메일로 가입"
            case .emptyEmail:
                return "확인"
            case .noUser:
                return "다시 시도"
            case .failureNetwork:
                return "확인"
            }
        }
    }
    
    @IBOutlet private weak var firstLineLabel: UILabel!
    @IBOutlet private weak var secondLineLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
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
        self.status = status
        
        if firstLineLabel != nil {
            configureView()
        }
    }
    
    private func configureView() {
        firstLineLabel.text = status.firstLineText
        secondLineLabel.text = status.secondLineText
        button.setTitle(status.buttonText, for: .normal)
    }
}

extension OneButtonAlertViewControllerDelegate where Self: UIViewController {
    func oneButtonAlertViewController(_ viewConotroller: OneButtonAlertViewController, tapped button: UIButton) {
        dismiss(animated: true)
    }
}
