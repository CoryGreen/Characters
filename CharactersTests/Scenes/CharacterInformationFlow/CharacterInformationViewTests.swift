//
//  CharacterInformationViewTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class MockCharacterInformationPresenter: CharacterInformationViewPresenter {
    
    required init(view: CharacterInformationView, item: CharacterInformation) {}
    
    private(set) var isViewDidLoadCalled = false
    func viewDidLoad() {
        isViewDidLoadCalled = true
    }
    
    private(set) var isProfileImageURLCalculated = false
    var profileImageURL: URL {
        isProfileImageURLCalculated = true
        return URL(string: "https://api.adorable.io/avatars/285/JohnDoe.png")!
    }
    
    private(set) var isCharacterNameCalculated = false
    var characterName: String {
        isCharacterNameCalculated = true
        return String()
    }
    
    private(set) var isNumberOfSectionsCalculated = false
    var numberOfSections: Int {
        isNumberOfSectionsCalculated = true
        return 1
    }
    
    private(set) var isNumberOfRowsInSectionCalculated = false
    func numberOfRows(in section: Int) -> Int {
        isNumberOfRowsInSectionCalculated = true
        return 1
    }
    
    private(set) var isObjectAtIndexPathCalculated = false
    func object(at indexPath: IndexPath) -> CharacterDetails? {
        isObjectAtIndexPathCalculated = true
        return nil
    }
    
    
}

class CharacterInformationViewTests: XCTestCase {

    var mockPresenter: MockCharacterInformationPresenter!
    var sutView: CharacterInformationViewController!
    var mockTable: UITableView!
    
    override func setUpWithError() throws {
        sutView = CharacterInformationViewController.instantiate()
        mockPresenter = MockCharacterInformationPresenter(view: sutView, item: mockModel)
        sutView.presenter = mockPresenter
        mockTable = UITableView()
        sutView.tableView = mockTable
        sutView.profileImageView = UIImageView()
        sutView.profileBackgroundView = UIView()
    }

    override func tearDownWithError() throws {
        mockTable = nil
        mockPresenter = nil
        sutView = nil
    }

    func testViewInformsPresenterOnViewDidLoad() {
        
        // When
        sutView.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockPresenter.isViewDidLoadCalled, "View should inform the presenter when 'viewDidLoad()' is called'")
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
        XCTAssertTrue(mockPresenter.isNumberOfRowsInSectionCalculated, "View should ask for number of rows when 'tableView(_:numberOfRowsInSection:)' is called'")
    }
    
    func testViewAsksForCellOnLoad() {
        
        // Given
        sutView.viewDidLoad()
        
        // When
        let zeroIndexPath = IndexPath(row: 0, section: 0)
        sutView.tableView.dataSource?.tableView(mockTable, cellForRowAt: zeroIndexPath)
        
        // Then
        XCTAssertTrue(mockPresenter.isObjectAtIndexPathCalculated, "View should ask for objects when 'tableView(_:cellForRowAt:)' is called'")
        
    }

}
