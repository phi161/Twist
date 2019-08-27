//
//  HTTPClient.swift
//  Twist
//

import Foundation
import Moya
import RxSwift

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
    
    func requestObservable<ER: Decodable>(target: LastfmTarget, keyPath: String, responseType: ER.Type) -> Observable<[ER]> {
        let b = provider.rx
            .request(target)
            .filterSuccessfulStatusCodes()
            .map([ER].self, atKeyPath: keyPath, using: JSONDecoder.init(), failsOnEmptyData: true)
            .asObservable()
        return b
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
