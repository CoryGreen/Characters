//
//  CharacterClientTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class CharacterClientTests: XCTestCase {
    
    var sutClient: CharacterClient!
    private let defaultTimeout = 5.0

    override func setUpWithError() throws {
        sutClient = CharacterClient(.init(configuration: .ephemeral))
    }

    override func tearDownWithError() throws {
        sutClient = nil
    }

    func testValidAPIConnection() throws {

        let all = CharacterRequest.all
        let promise = expectation(description: "Valid API Connection")
        
        sutClient.get(all) { _ in
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: defaultTimeout)
    }

    func testReceivedDataFromServer() throws {

        let all = CharacterRequest.all
        let promise = expectation(description: "Received Data from API")
        var connectionResult: Result<Data, APIError>?
        
        sutClient.get(all) { result in
            connectionResult = result
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: defaultTimeout)
        
        guard let actualResult = connectionResult else { return XCTFail() }
        
        switch actualResult {
            case .success(_): break
            case .failure(let error): XCTFail(error.localizedDescription)
        }
    }
}
