//
//  AppCoordinatorTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class AppCoordinatorTests: XCTestCase {
    
    var sutCoordinator: AppCoordinator!

    override func setUpWithError() throws {
        let window = UIWindow(frame: .zero)
        sutCoordinator = AppCoordinator(window: window, childCoordinators: [])
    }

    override func tearDownWithError() throws {
        sutCoordinator = nil
    }

    func testStartMethodSetsRootViewController() {
        // When
        sutCoordinator.start()
        // Then
        XCTAssertNotNil(sutCoordinator.window.rootViewController, "Coordinator's rootViewController must not be nil after `start` method call.")
    }
    
    func testStartMethodSetsRootViewControllerAsNavigationController() {
        // When
        sutCoordinator.start()
        // Then
        let result = sutCoordinator.window.rootViewController is UINavigationController
        
        XCTAssertTrue(result, "Coordinator's rootViewController shoulbe be a UINavigationController after `start` method call.")
    }

}
