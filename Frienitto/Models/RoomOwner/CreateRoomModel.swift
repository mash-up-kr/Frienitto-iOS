//
//  CreateRoomModel.swift
//  Frienitto
//
//  Created by Hyeontae on 11/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct CreateRoomModel: Codable {
    let code: Int
    let msg: String
    let data: CreateRoomModel.DataModel
    
    struct DataModel: Codable {
        let id: Int
        let title: String
        let expires_date: String
        let url: String
        let participants: [CreateRoomModel.UserInfo]
    }
    
    struct UserInfo: Codable {
        let id: Int
        let username: String
        let image_code: Int
    }
}
