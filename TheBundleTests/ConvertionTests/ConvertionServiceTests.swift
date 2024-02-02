//
//  ConvertionServiceTests.swift
//  TheBundleTests
//
//  Created by Perveaux Nicolas on 22/01/2024.
//

import XCTest
@testable import TheBundle


final class ConvertionServiceTests: XCTestCase {

    
    func testGetConvertionShouldPostFailedCallback() {
        // Given
        let convertionService = ConvertionService(
            convertionSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionService.getConvertion (currencyA:1) { (succes,settings, convertionResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(convertionResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
     
    func testGetConvertionShouldPostFailedCallbackIfNoData() {
        // Given
        let convertionService = ConvertionService(
            convertionSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionService.getConvertion (currencyA:1) { (succes,settings, convertionResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(convertionResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConvertionShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let convertionService = ConvertionService(
            convertionSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseKO , error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionService.getConvertion (currencyA:1) { (succes,settings, convertionResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(convertionResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConvertionShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let convertionService = ConvertionService(
            convertionSession: URLSessionFake (
                data: FakeResponseData.translateIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionService.getConvertion (currencyA:1) { (succes,settings, convertionResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(convertionResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConvertionShouldPostSuccessCallbackIfcorrectData() {
        // Given
        let convertionService = ConvertionService(
            convertionSession: URLSessionFake (
                data: FakeResponseData.convertionCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionService.getConvertion (currencyA:1) { (succes,settings, convertionResult) in
            
            // Then
            XCTAssertTrue(succes)
            XCTAssertNotNil(convertionResult)
            let result = 1.092091
            XCTAssertEqual(result, convertionResult?.rates.USD)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
   
}
