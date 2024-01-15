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
        url: URL(string: "https://https://xxxxxxx.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class TranslateError: Error {}
    static let error = TranslateError()
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let translateIncorrectData = "erreur".data(using: .utf8)!
    
}
