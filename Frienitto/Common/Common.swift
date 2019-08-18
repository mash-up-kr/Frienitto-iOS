//
//  Common.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/18.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

var activityIndicator: FrenttoActivityIndicatorView?

extension UIViewController {
        
    func showActivityIndicator() {
        if activityIndicator == nil {
            let activityIndicatorView = FrenttoActivityIndicatorView(frame: view.frame)
            activityIndicator = activityIndicatorView
            view.addSubview(activityIndicatorView)
        }
    }
}

func hideActivityIndicator() {
    activityIndicator?.removeFromSuperview()
    activityIndicator = nil
}
