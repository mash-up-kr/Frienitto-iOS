//
//  UIStoryboard+Instantiate.swift
//  Frienitto
//
//  Created by mang on 21/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func instantiate<T: UIViewController>(_ type: T.Type, name: String) -> T? {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        guard let name = NSStringFromClass(type.self).components(separatedBy: ".").last else { return nil }
        return storyboard.instantiateViewController(withIdentifier: name) as? T
    }
}

