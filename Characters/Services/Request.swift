//
//  Request.swift
//  Characters
//
//  Created by Coding. on 10/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var base: String { get }
    var path: String { get }
    var queries: [URLQueryItem]? { get }
}
extension Endpoint {
    
    var urlComponents: URLComponents {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = base
        components.path = path
        components.queryItems = queries
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }
}

enum CharacterRequest {
    case all
    case named(_ s: String)
}

extension CharacterRequest: Endpoint {
    
    var path: String {
        switch self {
            case .all, .named(_):
                return "/api/characters"
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
            case .all : return nil
            case .named(let s): return [URLQueryItem(name: "name", value: s)]
        }
    }
    
    var base: String { return "breakingbadapi.com" }
    
    var scheme: String { return "https" }
    
}
