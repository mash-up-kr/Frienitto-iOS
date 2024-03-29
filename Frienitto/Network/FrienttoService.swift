//
//  FrienttoService.swift
//  Frienitto
//
//  Created by Gaon Kim on 29/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation
import Moya

enum FrienttoService {
    case signUp(username: String, description: String, imageCode: Int, email: String, password: String)
    case signIn(email: String, password: String)
    case createRoom(title: String, code: String, daysAfterEnum: DaysButtonEnum)
    case joinRoom(title: String, code: String)
    case retrieveRoomList
    case retrieveRoomDetail(id: Int)
    case retrieveUserRoom
    case matchingStart(roomId: Int)
    case issueCode(receiverInfo: String, type: String)
    case authCode(receiverInfo: String, type: String, code: String)
    case matchingInfo(id: Int)
    case exitRoom(title: String)
}

extension FrienttoService: TargetType {
    var baseURL: URL {
        return URL(string: "https://codingsquid-side-project.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/sign-up"
        case .signIn:
            return "/sign-in"
        case .createRoom:
            return "/register/room"
        case .joinRoom:
            return "/join/room"
        case .retrieveRoomList:
            return "/room/list"
        case .retrieveRoomDetail(let id):
            return "/room/\(id)"
        case .retrieveUserRoom:
            return "/user/room"
        case .matchingStart:
            return "/matching"
        case .issueCode:
            return "/issue/code"
        case .authCode:
            return "/verify/code"
        case .matchingInfo(let id):
            return "/matching-info/room/\(id)"
        case .exitRoom:
            return "/exit/room"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp, .signIn, .createRoom, .matchingStart, .issueCode, .authCode, .joinRoom:
            return .post
        case .retrieveRoomList, .retrieveRoomDetail, .retrieveUserRoom, .matchingInfo:
            return .get
        case .exitRoom:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signUp(let username, let description, let imageCode, let email, let password):
            return .requestParameters(parameters: ["username": username,
                                                   "description": description,
                                                   "image_code": imageCode,
                                                   "email": email,
                                                   "password": password],
                                      encoding: JSONEncoding.default)
        case .signIn(let email, let password):
            return .requestParameters(parameters: ["email" : email,
                                                   "password": password],
                                      encoding: JSONEncoding.default)
        case .createRoom(let title, let code, let daysAfterEnum):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            
            var date: String {
                let oneDayInterval = TimeInterval(60 * 60 * 24)
                switch daysAfterEnum {
                case .threeDays:
                    return dateFormatter.string(from: Date(timeIntervalSinceNow: 3 * oneDayInterval))
                case .sevenDays:
                    return dateFormatter.string(from: Date(timeIntervalSinceNow: 7 * oneDayInterval))
                }
            }
            
            return .requestParameters(parameters: ["title": title,
                                                   "code": code,
                                                   "expires_date": date],
                                      encoding: JSONEncoding.default)
        case .joinRoom(let title, let code):
            return .requestParameters(parameters: ["title": title,
                                                   "code": code],
                                      encoding: JSONEncoding.default)
        case .retrieveRoomList:
            return .requestPlain
        case .retrieveRoomDetail:
            return .requestPlain
        case .retrieveUserRoom:
            return .requestPlain
        case .matchingStart(let roomId):
            return .requestParameters(parameters: ["room_id": roomId,
                                                   "type": "USER"],
                                      encoding: JSONEncoding.default)
        case .issueCode(let receiverInfo, let type):
            return .requestParameters(parameters: ["receiver_info": receiverInfo,
                                                   "type": type],
                                      encoding: JSONEncoding.default)
        case .authCode(let receiverInfo, let type, let code):
            return .requestParameters(parameters: ["receiver_info": receiverInfo,
                                                   "type": type,
                                                   "code": code],
                                      encoding: JSONEncoding.default)
        case .matchingInfo:
            return .requestPlain
        case .exitRoom(let title):
            return .requestParameters(parameters: ["title": title],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp:
            return ["Content-type": "application/json",
                    "X-Register-Token": registerToken]
        case .createRoom, .joinRoom, .retrieveRoomList, .retrieveRoomDetail, .retrieveUserRoom, .matchingStart, .matchingInfo, .exitRoom:
            return ["Content-type": "application/json",
                    "X-Authorization": authorizationToken]
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

extension FrienttoService {
    var registerToken: String {
        return UserDefaults.standard.string(forKey: "registerToken") ?? ""
    }
    
    var authorizationToken: String {
        return UserDefaults.standard.string(forKey: "authorizationToken") ?? ""
    }
}
