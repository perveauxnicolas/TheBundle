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
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error),
            weatherSessionB: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
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
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil),
            weatherSessionB: URLSessionFake(data: nil, response: nil, error: nil))
        
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
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData , response: FakeResponseData.responseKO , error: nil),
            weatherSessionB: URLSessionFake(data: FakeResponseData.weatherBCorrectData , response: FakeResponseData.responseKO , error: nil))
        
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
                error: nil),
            weatherSessionB: URLSessionFake(data: FakeResponseData.translateIncorrectData,
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
                error: nil),
            weatherSessionB: URLSessionFake(data: FakeResponseData.weatherBCorrectData,
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
    
    func testGetWeatherBShouldPostFailedCallback() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error),
            weatherSessionB: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherB() { (succes,settings, weatherResultB) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResultB)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherBShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil),
            weatherSessionB: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherB() { (succes,settings, weatherResultB) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResultB)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherBShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData , response: FakeResponseData.responseKO , error: nil),
            weatherSessionB: URLSessionFake(data: FakeResponseData.weatherBCorrectData , response: FakeResponseData.responseKO , error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherB() { (succes,settings, weatherResultB) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResultB)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherBShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake (
                data: FakeResponseData.translateIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil),
            weatherSessionB: URLSessionFake(data: FakeResponseData.translateIncorrectData,
                                            response: FakeResponseData.responseOK,
                                            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherB() { (succes,settings, weatherResultB) in
            // Then
            XCTAssertFalse(succes)
            XCTAssertNil(weatherResultB)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGetWeatherBShouldPostSuccessCallbackIfcorrectData() {
        // Given
        let weatherService = WeatherService (
            weatherSession: URLSessionFake (
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseOK,
                error: nil),
            weatherSessionB: URLSessionFake(data: FakeResponseData.weatherBCorrectData,
                                            response: FakeResponseData.responseOK,
                                            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherB() { (succes,settings, weatherResultB) in
            
            // Then
            XCTAssertTrue(succes)
            XCTAssertNotNil(weatherResultB)
            let result = "New York"
            XCTAssertEqual(result, weatherResultB?.name)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}

