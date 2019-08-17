//
//  TimerView.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/17.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    func configure(with component: DateComponents) {
        guard
            let date = component.day,
            let hour = component.hour,
            let minute = component.minute,
            let second = component.second else { return }
        
        dateLabel.text = "\(date)"
        hourLabel.text = "\(hour)"
        minuteLabel.text = "\(minute)"
        secondLabel.text = "\(second)"
    }
}
