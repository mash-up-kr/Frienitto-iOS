//
//  ErrorResponse.swift
//  Frienitto
//
//  Created by mang on 19/08/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_msg"
    }
    
    let errorCode: Int
    let errorMessage: String
}
