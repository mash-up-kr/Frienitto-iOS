//
//  Mission.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/15.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct Mission: Codable {
    let description: String?
    let from: User
    let to: User
    let id: Int
    let status: String
}
