//
//  JSONParserTests.swift
//  CharactersTests
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import XCTest
@testable import Characters

class JSONParserTests: XCTestCase {
    
     var testBundle: Bundle!

    override func setUpWithError() throws {
        testBundle = Bundle(for: type(of: self))
    }

    override func tearDownWithError() throws {
        testBundle = nil
    }

    func testEmptyDataParserThrowsException() {
        
        // Given empty data
        let emptyData = Data()
        
        // When we parse, an exception should be thrown
        XCTAssertThrowsError(try JSONParser.parse(emptyData, type: [CharacterInformation].self))
        
    }
    
    func testInavlidDataParserThrowsException() {
        
        let invalidData = "Hello, world".data(using: .utf8)!
        
        XCTAssertThrowsError(try JSONParser.parse(invalidData, type: [CharacterInformation].self))
    }
    
    func testSampleDataParserNoThrow() {
        
        let sampleDataPath = testBundle.path(forResource: "sampleResponse", ofType: "json")!
        let simpleData = try! Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
        
        XCTAssertNoThrow(try JSONParser.parse(simpleData, type: [CharacterInformation].self))
    }
    
    func testSampleDataParsedHasResults() {
        
        let sampleDataPath = testBundle.path(forResource: "sampleResponse", ofType: "json")!
        let simpleData = try! Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
        let result = try! JSONParser.parse(simpleData, type: [CharacterInformation].self)
        
        let count = result.count
        
        XCTAssertGreaterThanOrEqual(count, 1)
    }
}
