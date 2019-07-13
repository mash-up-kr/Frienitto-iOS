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
            roomNameField.borderStyle = .none
            roomNameField.inputAccessoryView = keyboardAccessaryView
            roomNameField.tag = 1
        }
    }
    
    @IBOutlet weak var roomPasswordField: UITextField! {
        didSet {
            roomPasswordField.borderStyle = .none
            roomPasswordField.keyboardType = .numberPad
            roomPasswordField.inputAccessoryView = keyboardAccessaryView
            roomPasswordField.tag = 2
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
            makeButton.addTarget(self, action: #selector(didTapMakeButton(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Property
    
    private lazy var keyboardAccessaryView: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let upButton = UIBarButtonItem(image: UIImage(named: "up-arrow"), style: .plain, target: self, action: #selector(didTapUpArrow))
        let downButton = UIBarButtonItem(image: UIImage(named: "down-arrow"), style: .plain, target: self, action: #selector(didTapDownArrow))
        let doneButton = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(didTapToolbarDoneButton))
        toolBar.items = [upButton, downButton, doneButton]
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }()
    
    private let provider = FrienttoProvider()
    private let buttonBackgroundLightGray = UIColor(named: "lightgrey")
    private let buttonTextGray = UIColor(named: "darkgrey")
    private var selectedDaysButton: DaysButtonEnum?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setDelegate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Method
    
    private func setNavigationItem() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
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
    
    // MARK: - objc
    
    @objc func didTapUpArrow() {
        roomPasswordField.resignFirstResponder()
        roomNameField.becomeFirstResponder()
    }
    
    @objc func didTapDownArrow() {
        roomNameField.resignFirstResponder()
        roomPasswordField.becomeFirstResponder()
    }
    
    @objc func didTapToolbarDoneButton() {
        if roomPasswordField.isFirstResponder {
            roomPasswordField.resignFirstResponder()
        } else if roomNameField.isFirstResponder {
            roomNameField.resignFirstResponder()
        }
        checkRoomInfoValidation()
    }
    
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
    @objc func didTapMakeButton(_ sender: UIButton) {
        let roomName = roomNameField.text!
        let roomPassword = roomPasswordField.text!
        let daysAfterEnum = selectedDaysButton!
        // TODO: 보내기 전 인터렉션
        provider.createRoom(title: roomName, password: roomPassword, daysAfterEnum: daysAfterEnum, completion: { [weak self] response in
            guard
                let self = self,
                let response = response else { return }
            do {
                let responseModel = try response.map(CreateRoomModel.self)
                
                let makeRoomStoryboard = UIStoryboard(name: "MakeRoom", bundle: nil)
                guard let makeRoomFinishViewController =
                    makeRoomStoryboard.instantiateViewController(withIdentifier: "MakeRoomFinishViewController") as? MakeRoomFinishViewController
                    else { fatalError("finish ViewController error") }
                makeRoomFinishViewController.roomNameString = roomName
                makeRoomFinishViewController.roomPasswordString = roomPassword
                makeRoomFinishViewController.buttonSelectedEnum = daysAfterEnum
                self.navigationController?.pushViewController(makeRoomFinishViewController, animated: true)
            } catch (let err) {
                print(err.localizedDescription)
            }
        }) { error in
            print(error.localizedDescription)
        }
        // END Of CreateRoom Scope
    }
}

extension MakeRoomViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard
            let toolbar = textField.inputAccessoryView as? UIToolbar,
            let upArrowButton = toolbar.items?[0],
            let downArrowButton = toolbar.items?[1]
            else { fatalError("textfield arrow") }
        
        if textField == roomNameField {
            upArrowButton.isEnabled = false
            downArrowButton.isEnabled = true
        } else if textField == roomPasswordField {
            upArrowButton.isEnabled = true
            downArrowButton.isEnabled = false
        }
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
