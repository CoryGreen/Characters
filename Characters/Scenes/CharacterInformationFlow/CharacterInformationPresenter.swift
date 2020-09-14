//
//  CharacterInformationPresenter.swift
//  Characters
//
//  Created by Coding. on 10/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

typealias CharacterDetails = (feild: String, value: String)

protocol CharacterInformationViewPresenter {
    
    init(view: CharacterInformationView, item: CharacterInformation)
    
    func viewDidLoad()
    
    var profileImageURL: URL { get }
    var characterName: String { get }
    
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func object(at indexPath: IndexPath) -> CharacterDetails?
    
}

class CharacterInformationPresenter: CharacterInformationViewPresenter {
    
    weak var view: CharacterInformationView?
    var item: CharacterInformation
    
    var details: [CharacterDetails]
    
    required init(view: CharacterInformationView, item: CharacterInformation) {
        self.view = view
        self.item = item
        self.details = []
    }
    
    var profileImageURL: URL { return item.imageURL }
    
    var characterName: String { return item.name }
    
    func viewDidLoad() {
        
        // Occupation
        details.append(("Portrayed By", item.portrayed))
        
        // Occupation
        details.append(("Occupation", item.occupation.joined(separator: ", ")))
        
        // Status
        details.append(("Status", item.status))
        
        // Nickname
        details.append(("Nickname", item.nickname))
        
        // Season Appearance
        details.append(("Appeared in:", item.appearance.map({ "Season \($0)" }).joined(separator: ", ")))
        
        view?.updateTableView()
        
    }
    
    var numberOfSections: Int { return 1 }
    
    func numberOfRows(in section: Int) -> Int {
        return details.count
    }
    
    func object(at indexPath: IndexPath) -> CharacterDetails? {
        if indexPath.row >= details.count { return nil }
        return details[indexPath.row]
    }
}
