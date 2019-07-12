//
//  SignUpModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct SignUpModel: Codable {
    struct Data: Codable {
        let username: String
        let description: String
        let imageCode: Int
        let email: String
        
        enum CodingKeys: String, CodingKey {
            case username, description, email
            case imageCode = "image_code"
        }
    }
    
    let code: Int
    let msg: String
    let data: Data
}
