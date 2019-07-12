//
//  SignInModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct SignInModel: Codable {
    struct Data: Codable {
        let token: String
        let tokenExpiresDate: String
        
        enum CodingKeys: String, CodingKey {
            case token
            case tokenExpiresDate = "token_expires_date"
        }
    }
    
    let code: Int
    let msg: String
    let data: Data
}
