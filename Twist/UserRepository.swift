//
//  UserRepository.swift
//  Twist
//

import Foundation
import RxSwift

protocol UserRepositoryType {
    func friends(user: String) -> Observable<[User]>
}

struct UserRepository: UserRepositoryType {
    var client: HTTPClient

    func friends(user: String) -> Observable<[User]> {
        return client
            .requestObservable(target: .friends(user: "ok_not_ok_"), keyPath: "friends.user", responseType: UserResponse.self)
            .map { $0.map {$0.user} }
    }
}
