//
//  CharacterInformationPresenterTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class MockCharacterInformationView: CharacterInformationView {
    
    private(set) var isTableUpdated = false
    func updateTableView() {
        isTableUpdated = true
    }
}

class CharacterInformationPresenterTests: XCTestCase {
    
    var mockView: MockCharacterInformationView!
    var sutPresenter: CharacterInformationViewPresenter!
    
    override func setUpWithError() throws {
        mockView = MockCharacterInformationView()
        sutPresenter = CharacterInformationPresenter(view: mockView, item: mockModel)
    }
    
    override func tearDownWithError() throws {
        mockView = nil
        sutPresenter = nil
    }
    
    func testTableIsUpdatedOnLoad() throws {
        
        // When
        sutPresenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.isTableUpdated, "Presenter should update the TableView after 'viewDidLoad()' is called'")
    }
    
    func testProfileURLIsCorrect() {
        
        // When
        let result = sutPresenter.profileImageURL
        
        // Then
        XCTAssertEqual(result, mockModel.imageURL, "Presenter should return the correct character name 'profileImageURL' is called")
        
    }
    
    func testCharacterNameIsCorrect() {
        
        // When
        let result = sutPresenter.characterName
        
        // Then
        XCTAssertEqual(result, mockModel.name, "Presenter should return the correct character name when 'characterName' is called")
        
    }
    
    func testPresenterReturnsNumberOfSections() {
        
        // Given
        sutPresenter.viewDidLoad()
        
        // When
        let result = sutPresenter.numberOfSections
        
        // Then
        XCTAssertGreaterThan(result, 0, "Presenter should return a non-zero value when 'numberOfSections' is called")
    }
    
    func testPresenterReturnsNumberOfRowsInSections() {
        
        // Given
        sutPresenter.viewDidLoad()
        
        // When
        let result = sutPresenter.numberOfRows(in: 0)
        
        // Then
        XCTAssertGreaterThan(result, 0, "Presenter should return a non-zero value when 'numberOfRows(_:)' is called")
    }
    
    func testPresenterReturnsValidObjectWhenInRange() {
        
        // Given
        sutPresenter.viewDidLoad()
        
        // When
        let result = sutPresenter.object(at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertNotNil(result, "Presenter should return a non-nil object when 'object(_:)' is called")
    }
    
    func testPresenterReturnsValidObjectWhenOutOfRange() {
        
        // Given
        sutPresenter.viewDidLoad()
        
        // When
        let result = sutPresenter.object(at: IndexPath(row:Int.max, section: 0))
        
        // Then
        XCTAssertNil(result, "Presenter should return a nil object when 'object(_:)' is called")
    }
}
