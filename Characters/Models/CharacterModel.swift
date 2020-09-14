//
//  Character.swift
//  Characters
//
//  Created by Coding. on 10/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

struct CharacterInformation: Codable {
    
    let id: Int
    let name: String
    //let birthday: Date
    let appearance: [Int]
    let occupation: [String]
    let imageURL: URL
    let nickname: String
    let portrayed: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case name, nickname, portrayed, appearance, occupation, status
        case id = "char_id"
        case imageURL = "img"
    }
    
}
