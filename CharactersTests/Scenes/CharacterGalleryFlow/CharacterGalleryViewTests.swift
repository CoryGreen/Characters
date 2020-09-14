//
//  CharacterGalleryViewTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class MockCharacterGalleryPresenter: CharacterGalleryViewPresenter {
    
    var view: CharacterGalleryView?
    
    var delegate: CharacterGallerySceneDelegate?
    
    var client: APIClient!
    
    var items: [CharacterInformation]
    
    required init(view: CharacterGalleryView, items: [CharacterInformation], client: APIClient) {
        self.view = view
        self.client = client
        self.items = items
    }
    
    private(set) var isViewloaded = false
    func viewDidLoad() {
        isViewloaded = true
    }
    
    private(set) var isNavigationTitleCalculated = false
    var navigationTitle: String {
        isNavigationTitleCalculated = true
        return String()
    }
    
    private(set) var isDefaultSearch = false
    func defaultSearch() {
        isDefaultSearch = true
    }
    
    var scopeTitles: [String] = ["One"]
    
    var isFilterActive: Bool = false
    
    private(set) var isSearchExecuted = false
    func search(for searchTerm: String?, withScope index: Int) {
        isSearchExecuted = true
    }
    
    private(set) var isHeightCalculated = false
    func heightForRow(at indexPath: IndexPath) -> Float {
        isHeightCalculated = true
        return 1
    }
    
    private(set) var isItemSelected = false
    func didSelectItem(at indexPath: IndexPath) {
        isItemSelected = true
    }
    
    private(set) var isNumberOfSectionsCalculated = false
    var numberOfSections: Int {
        isNumberOfSectionsCalculated = true
        return 1
    }
    
    private(set) var isNumberOfRowsCalculated = false
    func numberOfRows(in section: Int) -> Int {
        isNumberOfRowsCalculated = true
        return 1
    }
    
    private(set) var isObjectCalculated = false
    func object(at indexPath: IndexPath) -> CharacterInformation? {
        isObjectCalculated = true
        return nil
    }
    
}

class CharacterGalleryViewTests: XCTestCase {
    
    var sutView: CharacterGalleryViewController!
    var mockPresenter: MockCharacterGalleryPresenter!
    var mockTable: UITableView!
    
    override func setUpWithError() throws {
        sutView = CharacterGalleryViewController()
        mockPresenter = MockCharacterGalleryPresenter(view: sutView, items: [mockModel], client: MockClient(.shared))
        sutView.presenter = mockPresenter
        mockTable = UITableView()
        sutView.tableView = mockTable
    }
    
    override func tearDownWithError() throws {
        sutView = nil
        mockPresenter = nil
        mockTable = nil
    }
    
    func testViewInformsPresenterOnViewDidLoad() {
        
        // When
        sutView.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockPresenter.isViewloaded, "View should inform the presenter when 'viewDidLoad()' is called'")
    }
    
    func testViewAsksForSectionsOnLoad() {
        
        // Given
        sutView.viewDidLoad()
        
        // When
        _ = sutView.tableView.dataSource?.numberOfSections?(in: mockTable)
        
        // Then
        XCTAssertTrue(mockPresenter.isNumberOfSectionsCalculated, "View should ask for number of sections when 'numberOfSections(_:)' is called'")
    }
    
    func testViewAsksForRowsOnLoad() {
        
        // Given
        sutView.viewDidLoad()
        
        // When
        _ = sutView.tableView.dataSource?.tableView(mockTable, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertTrue(mockPresenter.isNumberOfRowsCalculated, "View should ask for number of rows when 'tableView(_:numberOfRowsInSection:)' is called'")
    }
    
    func testViewAsksForCellOnLoad() {
        
        // Given
        sutView.viewDidLoad()
        
        // When
        let zeroIndexPath = IndexPath(row: 0, section: 0)
        sutView.tableView.dataSource?.tableView(mockTable, cellForRowAt: zeroIndexPath)
        
        // Then
        XCTAssertTrue(mockPresenter.isObjectCalculated, "View should ask for objects when 'tableView(_:cellForRowAt:)' is called'")
        
    }
    
    func testViewAsksPresenterForCellHeight() {
        
        // Given
        sutView.viewDidLoad()
        
        // When
        let zeroIndexPath = IndexPath(row: 0, section: 0)
        _ = sutView.tableView.delegate?.tableView?(mockTable, heightForRowAt: zeroIndexPath)
        
        // Then
        XCTAssertTrue(mockPresenter.isHeightCalculated, "View should ask for height of rows when 'tableView(_heightForRowAt:)' is called'")
    }
    
    func testViewInformsPresenterOnItemSelection() {
        
        // Given
        sutView.viewDidLoad()
        
        // When
        let zeroIndexPath = IndexPath(row: 0, section: 0)
        sutView.tableView.delegate?.tableView?(mockTable, didSelectRowAt: zeroIndexPath)
        
        // Then
        XCTAssertTrue(mockPresenter.isItemSelected, "View should inform presenter when 'tableView(_:didSelectRowAt:)' is called'")
    }
    
    func testViewInformsPresenterShouldSearch() {
        
        // Given
        sutView.viewDidLoad()
        
        // When
        let searchController = sutView.searchController!
        sutView.updateSearchResults(for: searchController)
        
        // Then
        XCTAssertTrue(mockPresenter.isSearchExecuted, "View should inform presenter when 'updateSearchResults(for:)' is called'")
    }
    
}
