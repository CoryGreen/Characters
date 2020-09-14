//
//  CharacterGalleryPresenter.swift
//  Characters
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation

protocol CharacterGalleryViewPresenter {
    
    var view: CharacterGalleryView? { get set }
    var delegate: CharacterGallerySceneDelegate? { get set }
    init(view: CharacterGalleryView, items: [CharacterInformation], client: APIClient)
    
    func viewDidLoad()
    func defaultSearch()
    
    var navigationTitle: String { get }
    
    var isFilterActive: Bool { get set }
    var scopeTitles: [String] { get }
    func search(for searchTerm: String?, withScope index: Int)
    
    func didSelectItem(at indexPath: IndexPath)
    
    func heightForRow(at indexPath: IndexPath) -> Float
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func object(at indexPath: IndexPath) -> CharacterInformation?
    
}

enum TVSeason: String, CaseIterable {
    case all = "All", s1 = "S1", s2 = "S2", s3 = "S3", s4 = "S4", s5 = "S5"
    
    var intValue: Int {
        TVSeason.allCases.firstIndex(of: self) ?? 0
    }
    
}

class CharacterGalleryPresenter: CharacterGalleryViewPresenter {
    
    weak var view: CharacterGalleryView?
    weak var delegate: CharacterGallerySceneDelegate?
    var fetchedItems: [CharacterInformation]
    var client: APIClient
    
    var isFilterActive: Bool
    var filteredItems: [CharacterInformation] = []
    
    required init(view: CharacterGalleryView, items: [CharacterInformation], client: APIClient) {
        self.view = view
        self.fetchedItems = items
        self.client = client
        self.isFilterActive = false
    }
    
    var navigationTitle: String { return "Directory" }
    
    func viewDidLoad() {
        defaultSearch()
    }
    
    func defaultSearch() {
        let all = CharacterRequest.all
        performRequest(with: all)
    }
    
    private func performRequest(with request: Endpoint) {
        
        view?.showLoaderSpinner()
        
        client.get(request) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        self.fetchedItems = try JSONParser.parse(data, type: [CharacterInformation].self)
                        self.filteredItems = self.fetchedItems
                    } catch {
                        print(error)
                }
            }
            
            self.view?.hideLoaderSpinner()
            self.view?.updateTable()
        }
    }
    
    func search(for searchTerm: String?, withScope index: Int) {
        
        guard let newSeason = TVSeason(rawValue: scopeTitles[index]) else { return }
        
        filteredItems = fetchedItems.filter({
            
            var correctSeason = false
            
            switch newSeason {
                case .all: correctSeason = true
                default:
                    correctSeason =  $0.appearance.contains(newSeason.intValue)
            }
            
            guard let searchTerm = searchTerm else { return correctSeason }
            
            return correctSeason && $0.name.lowercased().contains(searchTerm.lowercased())
        })
        
        view?.updateTable()
    }
    
    var scopeTitles: [String] {
        return TVSeason.allCases.map({ $0.rawValue })
    }
    
    func heightForRow(at indexPath: IndexPath) -> Float {
        return 65
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let selectedItem = object(at: indexPath) else { return }
        delegate?.didSelect(selectedItem)
    }
    
    private var dataSource: [CharacterInformation] {
        return isFilterActive ? filteredItems : fetchedItems
    }
    
    var numberOfSections: Int {
        return dataSource.count == 0 ? 0 : 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource.count
    }
    
    func object(at indexPath: IndexPath) -> CharacterInformation? {
        if indexPath.row >= dataSource.count { return nil }
        return dataSource[indexPath.row]
    }
    
}
