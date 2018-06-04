//
//  GitSearchTests.swift
//  GitSearchTests
//
//  Created by Jonas Boateng on 29/03/2018.
//  Copyright © 2018 Jonas Boateng. All rights reserved.
//

import XCTest
@testable import GitSearch

class GitSearchTests: XCTestCase {
    
    var searchSession : URLSession?
    var searchTerm: String?
    override func setUp() {
        super.setUp()
        searchSession = URLSession(configuration: URLSessionConfiguration.default)
        searchTerm = "Degree53"
    }
    
    override func tearDown() {
        searchSession = nil
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Asynchronous test: faster fail
    func testSearchCompletes() {
        // given
        let url = URL(string: "https://api.github.com/search/repositories?q="+searchTerm!+"&sort=stars&order=desc")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = searchSession?.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
            
            print(response ?? "No response")
        }
        dataTask?.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testReadMe() {
        // given
        let url = URL(string: "https://github.com/Cavalletto/Degree53CodingTest/blob/master/README.md")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = searchSession?.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
            
            print(response ?? "No response")
        }
        dataTask?.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
