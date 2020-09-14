//
//  CharacterGalleryPresenterTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class MockCharacterGalleryView: CharacterGalleryView {
    
    private(set) var isSpinnerShown = false
    func showLoaderSpinner() {
        isSpinnerShown = true
    }
    
    private(set) var isSpinnerHidden = false
    func hideLoaderSpinner() {
        isSpinnerHidden = true
    }
    
    private(set) var isTableUpdated = false
    func updateTable() {
        isTableUpdated = true
    }
}

class MockSceneDelegate: CharacterGallerySceneDelegate {
    
    private(set) var isCharacterInformationSelected = false
    func didSelect(_ characterInformation: CharacterInformation) {
        isCharacterInformationSelected = true
    }
}

class CharacterGalleryPresenterTests: XCTestCase {
    
    var mockView: MockCharacterGalleryView!
    var sutPresenter: CharacterGalleryPresenter!

    override func setUpWithError() throws {
        mockView = MockCharacterGalleryView()
        sutPresenter = CharacterGalleryPresenter(view: mockView, items: [mockModel], client: MockClient(.shared))
    }

    override func tearDownWithError() throws {
        mockView = nil
    }

    func testTableIsUpdatedOnLoad() throws {
        
        // When
        sutPresenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.isTableUpdated, "The Table should be updated after 'viewDidLoad()' is called'")
    }
    
    func testOnLoadSpinneHUDIsShown() throws {
        
        // When
        sutPresenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.isSpinnerShown, "The Spinner should be asked to display when 'viewDidLoad()' is called'")
    }
    
    func testOnLoadSpinneHUDIsHidden() throws {
        
        // When
        sutPresenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.isSpinnerHidden, "The Spinner should be asked to hide when 'viewDidLoad()' is called'")
    }
    
    func testTableIsUpdatedOnDefaultSearch() throws {
        
        // When
        sutPresenter.defaultSearch()
        
        // Then
        XCTAssertTrue(mockView.isTableUpdated, "The Table should be updated after 'defaultSearch()' is called'")
    }
    
    func testTableIsUpdatedOnSearching() throws {
        
        // When
        sutPresenter.search(for: "", withScope: 0)
        
        // Then
        XCTAssertTrue(mockView.isTableUpdated, "The Table should be updated after 'search(_:)' is called'")
    }
    
    func testTableIsUpdatedOnChangingScope() throws {
        
        // When
        sutPresenter.search(for: nil, withScope: 0)
        
        // Then
        XCTAssertTrue(mockView.isTableUpdated, "The Table should be updated after 'didChangeScope(_:)' is called'")
    }
    
    func testScopeTilesAreReturned() {
        
        // When
        let result = sutPresenter.scopeTitles
        
        // Then
        XCTAssertGreaterThan(result.count, 0, "The presenter should return one or more scope titles")
    }
    
    func testPresenterReturnsValidHeightForRow() {
        
        // Given
        sutPresenter.viewDidLoad()
        
        // When
        let result = sutPresenter.heightForRow(at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertGreaterThan(result, 0, "Presenter should return a non-zero value when 'heightForRow(_:)' is called")
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
    
    func testPresenterInformsDelegateThatAValidItemHasBeenSelected() {
        
        // Given
        sutPresenter.viewDidLoad()
        let mockGallerySceneDelegate = MockSceneDelegate()
        sutPresenter.delegate = mockGallerySceneDelegate
        
        // When
        sutPresenter.didSelectItem(at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(mockGallerySceneDelegate.isCharacterInformationSelected, "Presenter should informs its delegate when 'didSelectItem(_:)' is called")
    }
    
    func testPresenterDoesNotInformDelegateThatAnInvalidItemHasBeenSelected() {
        
        // Given
        sutPresenter.viewDidLoad()
        let mockGallerySceneDelegate = MockSceneDelegate()
        sutPresenter.delegate = mockGallerySceneDelegate
        
        // When
        sutPresenter.didSelectItem(at: IndexPath(row: Int.max, section: 0))
        
        // Then
        XCTAssertFalse(mockGallerySceneDelegate.isCharacterInformationSelected, "Presenter should informs its delegate when 'didSelectItem(_:)' is called")
    }

}
