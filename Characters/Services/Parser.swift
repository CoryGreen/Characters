//
//  Parser.swift
//  Characters
//
//  Created by Coding. on 10/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

struct JSONParser {
    
    /// A Generic parser to serialize JSON data into usbale objects model ojects
    ///
    /// - Parameters:
    ///   - data: the JSON data to parse
    ///   - type: The type to parse into, it MUST conform to the Decodable protocol
    /// - Returns: serialize model object
    /// - Throws: An error if any value throws an error during decoding.
    static func parse<T>(_ data: Data, type: T.Type) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(T.self, from: data)
    }
    
}
