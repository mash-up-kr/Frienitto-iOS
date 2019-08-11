//
//  String+Date.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/12.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}
