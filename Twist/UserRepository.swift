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
            .requestObservable(target: .friends(user: user, limit: 3), keyPath: "friends.user", responseType: UserResponse.self)
            .map { $0.map {$0.user} }
    }

    func topTracks(user: String) -> Observable<[Track]> {
        return client
            .requestObservable(target: .topTracks(user: user, limit: 5), keyPath: "toptracks.track", responseType: TrackResponse.self)
            .map { $0.map {$0.track} }
    }

}
