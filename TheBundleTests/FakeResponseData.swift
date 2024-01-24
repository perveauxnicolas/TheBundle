//
//  TranslateFakeResponseData.swift
//  TheBundleTests
//
//  Created by Perveaux Nicolas on 11/01/2024.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://xxxxxxx.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://xxxxxxx.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var convertionCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Convertion", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
class TranslateError: Error {}
    static let error = TranslateError()
    
    static let translateIncorrectData = "erreur".data(using: .utf8)!
 
}
