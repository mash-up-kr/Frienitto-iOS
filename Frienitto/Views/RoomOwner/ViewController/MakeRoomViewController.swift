//
//  RoomOwnerViewController.swift
//  Frienitto
//
//  Created by Hyeontae on 29/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class MakeRoomViewController: UIViewController {
    
    @IBOutlet weak var roomName: UITextField! {
        didSet {
            roomName.borderStyle = .none
            roomName.inputAccessoryView = keyboardAccessaryView
            roomName.placeholder = "멋진 방 이름을 적어주세요"
            roomName.tag = 1
        }
    }
    @IBOutlet weak var roomPassword: UITextField! {
        didSet {
            roomPassword.borderStyle = .none
            roomPassword.keyboardType = .numberPad
            roomPassword.placeholder = "비밀번호를 적어주세요."
            roomPassword.inputAccessoryView = keyboardAccessaryView
            roomPassword.tag = 2
        }
    }
    
    @IBOutlet weak var makeRoomField: UIView!
    
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
            makeButton.addTarget(self, action: #selector(basicButton(_:)), for: .touchUpInside)
        }
    }
    
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
    
    private var nowTextFieldTag = 1
    private let buttonBackgroundLightGray = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
    private let buttonTextGray = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setDelegate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setNavigationItem() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setDelegate() {
        roomName.delegate = self
        roomPassword.delegate = self
    }
    
    @objc func didTapUpArrow() {
        roomPassword.resignFirstResponder()
        roomName.becomeFirstResponder()
    }
    
    @objc func didTapDownArrow() {
        roomName.resignFirstResponder()
        roomPassword.becomeFirstResponder()
    }
    
    @objc func didTapToolbarDoneButton() {
        if roomPassword.isFirstResponder {
            roomPassword.resignFirstResponder()
        } else if roomName.isFirstResponder {
            roomName.resignFirstResponder()
        }
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
        } else {
            threeDayAfterButton.backgroundColor = buttonBackgroundLightGray
            threeDayAfterButton.setTitleColor(buttonTextGray, for: .normal)
        }
        
        if sevenDayAfterButton.isSelected {
            sevenDayAfterButton.backgroundColor = self.view.backgroundColor
            sevenDayAfterButton.setTitleColor(.white, for: .normal)
        } else {
            sevenDayAfterButton.backgroundColor = buttonBackgroundLightGray
            sevenDayAfterButton.setTitleColor(buttonTextGray, for: .normal)
        }
        
        makeButton.backgroundColor = .orange
        makeButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func didTapMakeButton(_ sender: UIButton) {
        
    }
}

extension MakeRoomViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nowTextFieldTag = textField.tag
        guard let toolbar = textField.inputAccessoryView as? UIToolbar else {fatalError("toolbar")}
        if nowTextFieldTag == 1 {
            // up
            toolbar.items?.first?.isEnabled = false
            toolbar.items?[1].isEnabled = true
        } else if nowTextFieldTag == 2 {
            // down
            toolbar.items?.first?.isEnabled = true
            toolbar.items?[1].isEnabled = false
            
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            roomPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
