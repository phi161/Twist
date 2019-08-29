//
//  RecommendationsInteractor.swift
//  Twist
//

import Foundation
import RxSwift

struct RecommendationsInteractor {
    let userRepository: UserRepository
    
    private func topTracks(users: [User]) -> Observable<[Track]> {
        return Observable.from(users)
            .map{$0.name}
            .flatMap(userRepository.topTracks)
    }
    
    /**
     Gets a user's friends, and then for each friend requests their top tracks
     - Parameter user: A valid last.fm username
     - Returns: An `Observable` of tracks, where each element represents a friend's top tracks
     */
    func tracks(user: String) -> Observable<[Track]> {
        return userRepository.friends(user: user).flatMap(topTracks)
    }
}
