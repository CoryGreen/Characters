//
//  CharacterFlowCoordinatorTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

let mockModel = CharacterInformation(id: 0, name: "John Doe", appearance: [1], occupation: ["Mock Person"], imageURL: URL(string: "https://api.adorable.io/avatars/285/JohnDoe.png")!, nickname: "J'Doe", portrayed: "No one", status: "Here")

enum MockClientState {
    case success
    case failure
}

class MockClient: APIClient {
    
    required init(_ session: URLSession) {
        self.session = session
    }
    
    var session: URLSession
    var state: MockClientState = .failure
    
    func get(_ endpoint: Endpoint, completion: @escaping APICompletion) {
        
        switch state {
            case .failure:
            completion(.failure(.responseUnsuccessful))
            default:
                let data = try! JSONEncoder().encode([mockModel, mockModel, mockModel])
                completion(.success(data))
        }
        
    }
    
}

class CharacterFlowCoordinatorTests: XCTestCase {
    
    var sutCoordinator: CharacterFlowCoordinator!
    var navigation: UINavigationController!
    var client: APIClient!
    
    override func setUpWithError() throws {
        
        navigation = UINavigationController()
        client = MockClient(.shared)
        sutCoordinator = CharacterFlowCoordinator(navigation, client: client)
    }
    
    override func tearDownWithError() throws {
        sutCoordinator = nil
        client = nil
        navigation = nil
    }
    
    func testStartMethodSetsRootViewController() {
        
        // When
        sutCoordinator.start()
        
        // Then
        XCTAssertNotNil(navigation.viewControllers.first, "Navigations rootViewController must not be nil after `start` method call.")
    }
    
    func testStartMethodSetsRootViewControllerAsCharacterGalleryViewController() {
        
        // When
        sutCoordinator.start()
        
        // Then
        let result = navigation.viewControllers.first is CharacterGalleryViewController
        XCTAssertTrue(result, "Coordinator's rootViewController shoulbe be a CharacterGalleryViewController after `start` method call.")
    }
    
    func testOnSelectingCharacterPushesViewController() {
        
        // When
        sutCoordinator.start()
        sutCoordinator.didSelect(mockModel)
        
        // Then
        XCTAssertTrue(navigation.visibleViewController is CharacterGalleryViewController, "NavigationController must now display CharacterGalleryViewController after `didSelect(_:)` method call.")
    }
}
