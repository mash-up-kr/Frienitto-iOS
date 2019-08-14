//
//  MatchingInfoModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/15.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct MatchingInfoModel: Codable {
    let code: String
    let msg: String
    let data: [Mission]
}
