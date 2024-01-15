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
        translateService.getTranslate(frenchText: "bonjour") { (success, translations) in
            // Then
                XCTAssertFalse(success)
                XCTAssertNil(translations)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 0.01)
            }
            
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
                // Given
                let translateService = TranslateService (
                    translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                    
                    // When
                    let expectation = XCTestExpectation(description: "Wait for queue change.")
                    translateService.getTranslate { (success, translate) in
                        // Then
                        XCTAssertFalse(((success) != 0))
                        XCTAssertNil(translate)
                        expectation.fulfill()
                    }
                    
                    wait(for: [expectation], timeout: 0.01)
                    }
                    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
                        // Given
                        let translateService = TranslateService (
                            translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData , response: FakeResponseData.responseKO , error: nil),
                            
                            // When
                            let expectation = XCTestExpectation(description: "Wait for queue change.")
                            translateService.getTranslate { (success, translate) in
                                // Then
                                XCTAssertFalse(((success) != 0))
                                XCTAssertNil(translate)
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
                                        error: nil),
                                    
                                    // When
                                    let expectation = XCTestExpectation(description: "Wait for queue change.")
                                    translateService.getTranslate { (success, translate) in
                                        // Then
                                        XCTAssertFalse(((success) != 0))
                                        XCTAssertNil(translate)
                                        expectation.fulfill()
                                    }
                                    
                                    wait(for: [expectation], timeout: 0.01)
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    }
