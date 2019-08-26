//
//  HTTPClient.swift
//  Twist
//

import Foundation
import Moya

struct HTTPClient {
    
    let provider: MoyaProvider<LastfmTarget>
    
    init(isStubbed: Bool = false, tokenProvider: TokenProvider = TokenProvider()) {
        if isStubbed {
            provider = MoyaProvider<LastfmTarget>(stubClosure: MoyaProvider.delayedStub(3))
        } else {
            provider = MoyaProvider<LastfmTarget>(plugins: [
                LastfmAuthPlugin(token: tokenProvider.lastfmToken),
                NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)
                ])
        }
    }
    
    func requestTopTracks(_ user: String) {
        provider.request(.topTracks(user: user)) { (result) in
            switch result {
            case let .success(value):
                print(value)
            case let .failure(error):
                print(error)
            }
        }
    }

}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}
