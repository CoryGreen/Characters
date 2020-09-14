//
//  CharacterRequestTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class CharacterRequestTests: XCTestCase {

    func testCharacterRequestAllHasCorrectBaseURL() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters")!
        
        // When
        let sutRequest = CharacterRequest.all
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutBaseURL = components.host
        XCTAssertEqual(sutBaseURL, expectedComponents.host)
        
    }
    
    func testCharacterRequestAllHasCorrectPath() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters")!
        
        // When
        let sutRequest = CharacterRequest.all
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutPath = components.path
        XCTAssertEqual(sutPath, expectedComponents.path)
        
    }
    
    func testCharacterRequestAllHasCorrectQueryItems() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters")!
        
        // When
        let sutRequest = CharacterRequest.all
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutQueryItems = components.queryItems
        XCTAssertEqual(sutQueryItems, expectedComponents.queryItems)
        
    }
    
    func testCharacterRequestAllHasCorrectScheme() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters")!
        
        // When
        let sutRequest = CharacterRequest.all
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutScheme = components.scheme
        XCTAssertEqual(sutScheme, expectedComponents.scheme)
        
    }
    
    func testCharacterRequestSearchHasCorrectScheme() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters?name=Walter")!
        
        // When
        let sutRequest = CharacterRequest.named("Walter")
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutScheme = components.scheme
        XCTAssertEqual(sutScheme, expectedComponents.scheme)
        
    }
    
    func testCharacterRequestSearchHasCorrectBaseURL() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters?name=Walter")!
        
        // When
        let sutRequest = CharacterRequest.named("Walter")
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutHost = components.host
        XCTAssertEqual(sutHost, expectedComponents.host)
        
    }
    
    func testCharacterRequestSearchHasCorrectPath() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters?name=Walter")!
        
        // When
        let sutRequest = CharacterRequest.named("Walter")
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutPath = components.path
        XCTAssertEqual(sutPath, expectedComponents.path)
        
    }
    
    func testCharacterRequestSearchHasCorrectQueryItems() {
        
        // Given
        let expectedComponents = URLComponents(string: "https://breakingbadapi.com/api/characters?name=Walter")!
        
        // When
        let sutRequest = CharacterRequest.named("Walter")
        let components = URLComponents(url: (sutRequest.request?.url!)!, resolvingAgainstBaseURL: false)!
        
        // Then
        let sutQueryItems = components.queryItems
        XCTAssertEqual(sutQueryItems, expectedComponents.queryItems)
        
    }

}
