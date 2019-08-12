//
//  TwoButtonAlertViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/13.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

protocol TwoButtonAlertViewControllerDelegate: AnyObject {
    func twoButtonAlertViewController(_ viewController: TwoButtonAlertViewController, tapped button: UIButton)
}

class TwoButtonAlertViewController: UIViewController {
    
    enum Status {
        case logout
    }
    
    @IBOutlet private weak var firstLineLabel: UILabel!
    @IBOutlet private weak var secondLineLabel: UILabel!
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    
    private var firstLineText: String?
    private var secondLineText: String?
    private var firstButtonText: String?
    private var secondButtonText: String?
    
    weak var delegate: TwoButtonAlertViewControllerDelegate?
    var status: Status = .logout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configure(status: Status) {
        switch status {
        case .logout:
            configureLogoutStatus()
        }
    }
    
    private func configureLogoutStatus() {
        firstLineText = "정말 로그아웃"
        secondLineText = "하시겠습니까?"
        firstButtonText = "네"
        secondButtonText = "아니요"
    }
    
    private func configureView() {
        firstLineLabel.text = firstLineText
        secondLineLabel.text = secondLineText
        firstButton.setTitle(firstButtonText, for: .normal)
        secondButton.setTitle(secondButtonText, for: .normal)
    }
    
    @IBAction private func firstButtonAction(_ sender: UIButton) {
        delegate?.twoButtonAlertViewController(self, tapped: sender)
    }
    
    @IBAction private func secondButtonAction(_ sender: UIButton) {
        delegate?.twoButtonAlertViewController(self, tapped: sender)
    }
}

extension TwoButtonAlertViewControllerDelegate where Self: UIViewController {
    func twoButtonAlertViewController(_ viewController: TwoButtonAlertViewController, tapped button: UIButton) {
        switch viewController.status {
        case .logout:
            logoutAction(tapped: button)
        }
    }
    
    private func logoutAction(tapped button: UIButton) {
        dismiss(animated: true) {
            if button.currentTitle == "네" {
                guard let viewController = UIStoryboard.instantiate(LoginSignViewController.self, name: "Login") else { return }
                self.navigationController?.setViewControllers([viewController], animated: true)
            }
        }
    }
}
