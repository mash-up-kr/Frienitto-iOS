//
//  RoomOwnerViewController.swift
//  Frienitto
//
//  Created by Hyeontae on 29/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class MakeRoomViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var roomNameField: UITextField! {
        didSet {
            roomNameField.delegate = self
        }
    }
    
    @IBOutlet weak var roomPasswordField: UITextField!{
        didSet {
            roomPasswordField.delegate = self
        }
    }
    
    @IBOutlet weak var threeDayAfterButton: UIButton! {
        didSet {
            threeDayAfterButton.addTarget(self, action: #selector(basicButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var sevenDayAfterButton: UIButton! {
        didSet {
            sevenDayAfterButton.addTarget(self, action: #selector(basicButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var makeButton: UIButton! {
        didSet {
            setMakeButton(false)
        }
    }
    
    // MARK: - Property
    
    private let provider = FrienttoProvider()
    private let buttonBackgroundLightGray = UIColor(named: "lightgrey")
    private let buttonTextGray = UIColor(named: "darkgrey")
    private var selectedDaysButton: DaysButtonEnum?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }
    
    // MARK: - Method
    
    private func setDelegate() {
        roomNameField.delegate = self
        roomPasswordField.delegate = self
    }
    
    // TODO: roomNameField validation check
    
    private func checkRoomInfoValidation() {
        
        guard let roomName = roomNameField.text,
            let password = roomPasswordField.text
            else {
                setMakeButton(false)
                return
            }
        
        if roomName.isEmpty {
            return
        }
        
        if password.count < 4 {
            setMakeButton(false)
            return
        }
        
        if selectedDaysButton == nil {
            setMakeButton(false)
            return
        }
        
        setMakeButton(true)
    }
    
    private func setMakeButton(_ validation: Bool) {
        makeButton.isEnabled = validation
        if validation {
            makeButton.backgroundColor = UIColor(named: "orange")
        } else {
            makeButton.backgroundColor = UIColor(named: "darkgrey")
        }
    }

    // MARK: - Objc
    
    @objc func basicButton(_ sender: UIButton) {
        sender.isSelected = true
        
        if sender == threeDayAfterButton {
            sevenDayAfterButton.isSelected = false
        } else {
            threeDayAfterButton.isSelected = false
        }
        
        if threeDayAfterButton.isSelected {
            threeDayAfterButton.backgroundColor = self.view.backgroundColor
            threeDayAfterButton.setTitleColor(.white, for: .normal)
            selectedDaysButton = DaysButtonEnum(rawValue: 3)
        } else {
            threeDayAfterButton.backgroundColor = buttonBackgroundLightGray
            threeDayAfterButton.setTitleColor(buttonTextGray, for: .normal)
        }
        
        if sevenDayAfterButton.isSelected {
            sevenDayAfterButton.backgroundColor = self.view.backgroundColor
            sevenDayAfterButton.setTitleColor(.white, for: .normal)
            selectedDaysButton = DaysButtonEnum(rawValue: 7)
        } else {
            sevenDayAfterButton.backgroundColor = buttonBackgroundLightGray
            sevenDayAfterButton.setTitleColor(buttonTextGray, for: .normal)
        }
        
        checkRoomInfoValidation()
    }
    
    // TODO: API Connect
    
    @IBAction func didTapMakeButton(_ sender: UIButton) {
        let roomName = roomNameField.text!
        let roomPassword = roomPasswordField.text!
        let daysAfterEnum = selectedDaysButton!
        
        // TODO: 보내기 전 인터렉션
        showActivityIndicator()
        provider.createRoom(title: roomName, password: roomPassword, daysAfterEnum: daysAfterEnum, completion: { [weak self] createRoomModel in
            guard let makeRoomFinishViewController = UIStoryboard.instantiate(MakeRoomFinishViewController.self, name: "MakeRoom"),
            let roomList = UIStoryboard.instantiate(MainListViewController.self, name: "Main") else { return }
            
            makeRoomFinishViewController.roomNameString = roomName
            makeRoomFinishViewController.roomPasswordString = roomPassword
            makeRoomFinishViewController.buttonSelectedEnum = daysAfterEnum
            
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: roomList)
            
            self?.dismiss(animated: true, completion: {
                UIApplication.topViewController()?.present(makeRoomFinishViewController, animated: true, completion: nil)
            })
        }, failure: { error, errorResult in
            if errorResult?.errorCode == 409 {
                guard let alertViewController = UIStoryboard.instantiate(OneButtonAlertViewController.self, name: "Login") else { return }
                
                alertViewController.delegate = self
                alertViewController.configure(status: .overlapRoom)
                
                self.present(alertViewController, animated: true)
            }
            print(error.localizedDescription)
        })
    }
    
    // MARK: - IBAction
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MakeRoomViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkRoomInfoValidation()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            roomPasswordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        checkRoomInfoValidation()
        return true
    }
}

extension MakeRoomViewController: OneButtonAlertViewControllerDelegate { }
