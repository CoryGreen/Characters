//
//  CoodinatorTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

// MARK: - Mock Coordinator
/// Created for testing of Coordinator's protocol default implementation in extension.
class MockCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([MockViewController()], animated: false)
    }
}

// MARK: - Mock ViewController
/// Created for testing of Coordinator's protocol default implementation in extension.
class MockViewController: UIViewController {}

// MARK: - Coodinator Tests
class CoodinatorTests: XCTestCase {
    
    var sutCoordinator: MockCoordinator!
    
    override func setUpWithError() throws {
        super.setUp()
        sutCoordinator = MockCoordinator()
    }
    
    override func tearDownWithError() throws {
        sutCoordinator = nil
        super.tearDown()
    }
    
    func testStartMethod() {
        
        // When
        sutCoordinator.start()
        
        // Then
        XCTAssertFalse(sutCoordinator.navigationController.viewControllers.isEmpty, "Coordinator's navigationController must not be empty after `start` method call.")
    }
    
    func testChildCoordinatorsSingleStorage() {
        
        // Given
        let testCoordinator = MockCoordinator()
        
        // When
        sutCoordinator.store(testCoordinator)
        
        // Then
        XCTAssertNotNil(sutCoordinator.childCoordinators.filter({$0 === testCoordinator}).first, "Added `testCoordiantor` must exists at childCoordinators collection.")
    }
    
    func testChildCoordinatorsMultipleStorage() {
        
        // Given
        let testCoordinator = MockCoordinator()
        
        // When
        sutCoordinator.store(testCoordinator)
        sutCoordinator.store(testCoordinator)
        
        // Then
        XCTAssertEqual(sutCoordinator.childCoordinators.count, 1, "Added `testCoordiantor` must still exists in single form.")
    }
    
    func testChildCoordinatorsReleasing() {
        
        // Given
        let testCoordinator = MockCoordinator()
        sutCoordinator.store(testCoordinator)
        
        // When
        sutCoordinator.free(testCoordinator)
        
        // Then
        XCTAssertNil(sutCoordinator.childCoordinators.filter({$0 === testCoordinator}).first, "Removed `testCoordiantor` must not exists at childCoordinators collection.")
    }
    
}
