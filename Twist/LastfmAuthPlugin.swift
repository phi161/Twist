//
//  LastfmAuthPlugin.swift
//  Twist
//

import Foundation
import Moya

/**
 Adds a query parameter with the API token to each request
 */
struct LastfmAuthPlugin: PluginType {
    
    let token: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let url = request.url else { return request }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return request }
        
        var mutableComponents = components
        mutableComponents.queryItems?.append(URLQueryItem(name: "api_key", value: token))
        
        var mutableRequest = request
        mutableRequest.url = mutableComponents.url
        return mutableRequest
    }

}
