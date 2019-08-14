//
//  SignUpModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct SignUpModel: Codable {
    let code: Int
    let msg: String
    let data: User
}
