//
//  User.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct User: Codable {
    let imageCode: Int
    let username: String
    let id: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, username, description
        case imageCode = "image_code"
    }
}
