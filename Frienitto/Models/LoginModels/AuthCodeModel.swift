//
//  AuthCodeModel.swift
//  Frienitto
//
//  Created by mang on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

struct AuthCodeModel: Codable {
    let code: Int
    let msg: String
    let data: Data
    
    struct Data: Codable {
        let registerToken: String
        
        enum CodingKeys: String, CodingKey {
            case registerToken = "register_token"
        }
    }
}
