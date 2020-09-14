//
//  Client.swift
//  Characters
//
//  Created by Coding. on 10/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

typealias APICompletion = (Result<Data, APIError>) -> Void

// A list of possible errors, to be used with the ENUMs above
enum APIError: Error {
    
    case requestFailed
    case invalidRequest
    case invalidData
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
            case .requestFailed: return "Request Failed"
            case .invalidRequest: return "Invalid Request"
            case .invalidData: return "Invalid Data"
            case .responseUnsuccessful: return "Response Unsuccessful"
        }
    }
}

// A simpel protocol for a simple client
protocol APIClient {
    
    init(_ session: URLSession)
    
    var session: URLSession { get }
    
    func get(_ endpoint: Endpoint, completion: @escaping APICompletion)
    
}

// An extension to the client to execute the request
extension APIClient {
    
    func execute(_ request: URLRequest, completion: @escaping APICompletion) {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return completion(.failure(.requestFailed)) }
            
            switch httpResponse.statusCode {
                case 200...299:
                    guard let data = data else { return completion(.failure(.invalidData)) }
                    return  completion(.success(data))
                default:
                    return completion(.failure(.responseUnsuccessful))
                
            }
            
        }
        
        task.resume()
    }
}

class CharacterClient: APIClient {
    
    let session: URLSession
    
    required init(_ session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func get(_ list: Endpoint, completion: @escaping APICompletion) {
        guard let request = list.request else { return completion(.failure(.invalidRequest)) }
        execute(request, completion: completion)
        
    }
}
