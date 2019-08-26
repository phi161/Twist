//
//  LastfmTarget.swift
//  Twist
//

import Foundation
import Moya

enum LastfmTarget {
    case topTracks(user: String)

    private func stubbedResponse(_ filename: String) -> Data {
        let path = Bundle.main.path(forResource: filename, ofType: "json")
        return (try! Data(contentsOf: URL(fileURLWithPath: path!)))
    }

}

extension LastfmTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://ws.audioscrobbler.com")!
    }
    
    var path: String {
        return "2.0"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var parameters = [
            "format": "json"
        ]
        switch self {
        case let .topTracks(user):
            parameters["method"] = "user.gettoptracks"
            parameters["user"] = user
        }
        return Task.requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return stubbedResponse("topTracks")
    }
    
}
