//
//  UserRepository.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 17/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import Moya

enum ApiError: Error {
    case parseError(Error)
    case servError
}

class UserRepository {
    
    fileprivate var userProvider: MoyaProvider<UserNetwork>
    
    init(userProvider: MoyaProvider<UserNetwork>) {
        self.userProvider = userProvider
    }
    
    func getUsers(at page: Int, handler: @escaping (Result<Users, ApiError>) -> Void) {
        
        self.userProvider.request(.user(page: page)) { result in
            
            switch result {
            case .success(let response):
                do {
                    let users = try JSONDecoder().decode(Users.self, from: response.data)
                    handler(.success(users))
                } catch let error {
                    print(error)
                    handler(.failure(.parseError(error)))
                }
                
            case .failure(let error):
                print(error)
                handler(.failure(.servError))
            }
        }
    }
}
