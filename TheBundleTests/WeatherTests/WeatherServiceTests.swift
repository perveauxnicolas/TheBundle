//
//  WeatherServiceTests.swift
//  TheBundleTests
//
//  Created by Perveaux Nicolas on 24/01/2024.
//

import XCTest
@testable import TheBundle

final class WeatherServiceTests: XCTestCase {
    
    
    func testGetWeatherShouldPostFailedCallback() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather() { (succes,settings, weatherResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather() { (succes,settings, weatherResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseKO , error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather() { (succes,settings, weatherResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake (
                data: FakeResponseData.translateIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather() { (succes,settings, weatherResult) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGetWeatherShouldPostSuccessCallbackIfcorrectData() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake (
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather() { (succes,settings, weatherResult) in
            
            // Then
            XCTAssertTrue(succes)
            XCTAssertNotNil(weatherResult)
            let result = "Paris"
            XCTAssertEqual(result, weatherResult?.name)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    
}

