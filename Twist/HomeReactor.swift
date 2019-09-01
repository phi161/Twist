//
//  HomeReactor.swift
//  Twist
//

import Foundation
import ReactorKit
import RxSwift

class HomeReactor: Reactor {
    
    let recommendationsInteractor: RecommendationsInteractorType

    init(interactor: RecommendationsInteractorType) {
        self.recommendationsInteractor = interactor
    }
    
    struct State {
        var tracks: [Track] = []
        var isLoading: Bool = false
    }
    
    var initialState: HomeReactor.State {
        return State()
    }

    enum Action {
        case requestTracks(user: String)
    }
    
    enum Mutation {
        case setTracks([Track])
        case setLoading(Bool)
    }
    
    func mutate(action: HomeReactor.Action) -> Observable<HomeReactor.Mutation> {
        switch action {
        case let .requestTracks(user):
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                recommendationsInteractor.tracks(user: user).map { Mutation.setTracks($0)},
                Observable.just(Mutation.setLoading(false))
                ])
        }
    }
    
    func reduce(state: HomeReactor.State, mutation: HomeReactor.Mutation) -> HomeReactor.State {
        var newState = state
        switch mutation {
        case let .setTracks(tracks):
            newState.tracks.append(contentsOf: tracks)
        case let .setLoading(loading):
            newState.isLoading = loading
        }
        return newState
    }
    
}
