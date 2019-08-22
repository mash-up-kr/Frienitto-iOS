//
//  TimerViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/17.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: CircleImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var timerView: TimerView!
    
    var expiresDate: Date = Date()
    var timer: Timer?
    var isOwner: Bool = false
    var mission: Mission?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewsUsingUserInfo()
        updateTimerView(with: calculateDateOffset())
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTimerView(with: calculateDateOffset())
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension TimerViewController {
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(
                withTimeInterval: 1,
                repeats: true) { [weak self] _ in
                    guard let self = self else { return }
                    self.updateTimerView(with: self.calculateDateOffset())
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func calculateDateOffset() -> DateComponents {
        let offsetComponent =
            Calendar(identifier: .gregorian)
                .dateComponents([.day, .hour, .minute, .second],
                                from: Date(),
                                to: expiresDate)
        
        return offsetComponent
    }
    
    private func updateTimerView(with component: DateComponents) {
        DispatchQueue.main.async { [weak self] in
            self?.timerView.configure(with: component)
        }
    }
    
    private func updateViewsUsingUserInfo() {
        completeButton.isHidden = !isOwner
        
        if let mission = mission {
            usernameLabel.text = mission.to.username
            userDescriptionLabel.text = mission.to.description
        }
    }
}
