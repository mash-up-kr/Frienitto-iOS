//
//  FrienttoProvider.swift
//  Frienitto
//
//  Created by Gaon Kim on 29/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation
import Moya
import Result

class FrienttoProvider {
    let provider = MoyaProvider<FrienttoService>()
    
    func signUp(username: String,
                description: String,
                imageCode: Int,
                email: String,
                password: String,
                completion: @escaping ((SignUpModel) -> Void),
                failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.signUp(username: username, description: description, imageCode: imageCode, email: email, password: password)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping ((SignInModel) -> Void),
                failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.signIn(email: email, password: password)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func createRoom(title: String,
                    password: String,
                    daysAfterEnum: DaysButtonEnum,
                    completion: @escaping ((CreateRoomModel) -> Void),
                    failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.createRoom(title: title, code: password, daysAfterEnum: daysAfterEnum)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
        
    }
    
    func joinRoom(title: String,
                  code: String,
                  completion: @escaping ((JoinRoomModel) -> Void),
                  failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.joinRoom(title: title, code: code)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func retrieveRoomList(completion: @escaping ((RoomListModel) -> Void),
                          failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.retrieveRoomList) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func retrieveRoomDetail(id: Int,
                            completion: @escaping ((RetrieveRoomDetailModel) -> Void),
                            failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.retrieveRoomDetail(id: id)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func retrieveUserRoom(completion: @escaping ((RoomListModel) -> Void),
                          failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.retrieveUserRoom) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func matchingStart(roomId: Int,
                       completion: @escaping ((MatchingStartModel) -> Void),
                       failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.matchingStart(roomId: roomId)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func issueCode(receiverInfo: String,
                   type: String,
                   completion: @escaping ((IssueCodeModel) -> Void),
                   failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.issueCode(receiverInfo: receiverInfo, type: type)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    func authCode(receiverInfo: String,
                  type: String,
                  code: String,
                  completion: @escaping ((AuthCodeModel) -> Void),
                  failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.authCode(receiverInfo: receiverInfo, type: type, code: code)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func matchingInfo(roomId: Int,
                      completion: @escaping ((MatchingInfoModel) -> Void),
                      failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        provider.request(.matchingInfo(id: roomId)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func exitRoom(title: String,
                  completion: @escaping (() -> Void)) {
        provider.request(.exitRoom(title: title)) { result in
            completion()
        }
    }
}

extension FrienttoProvider {
    func resultTask<T: Decodable>(_ result: Result<Response, MoyaError>,
                    completion: @escaping ((T) -> Void),
                    failure: @escaping ((Error, ErrorResponse?) -> Void)) {
        do {
            hideActivityIndicator()
            
            switch result {
            case .success(let response):
                completion(try response.map(T.self))
            
            case .failure(MoyaError.underlying(let error, let response)):
                guard let response = response else {
                    failure(error, nil)
                    return
                }
                failure(error, try response.map(ErrorResponse.self))
            
            case .failure(let error):
                failure(error, nil)
            }
        } catch let error {
            hideActivityIndicator()
            failure(error, nil)
        }
    }
}
