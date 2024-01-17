//
//  TranslateServiceTests.swift
//  TheBundleTests
//
//  Created by Perveaux Nicolas on 11/01/2024.
//

import XCTest
@testable import TheBundle


class TranslateServiceTests: XCTestCase {
    
    func testGetTranslateShouldPostFailedCallback() {
        // Given
        let translateService = TranslateService (
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
    TranslateService.shared.getTranslation(frenchText: "x") { (succes,settings, translationResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 00.01)
    }
    /*
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService (
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        TranslateService.shared.getTranslation(frenchText: "x") { (succes,settings, translationResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService (
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseKO , error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        TranslateService.shared.getTranslation(frenchText: "x") { (succes,settings, translationResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslateService (
            translateSession: URLSessionFake (
                data: FakeResponseData.translateIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        TranslateService.shared.getTranslation(frenchText: "x") { (succes,settings, translationResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    */
}
