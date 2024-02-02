//
//  TranslateService.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 10/01/2024.
//

import Foundation


class TranslateService {
    
    // MARK: - PROPERTIES
    static var shared = TranslateService()
    private let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    private let apikeyTranslate = "AIzaSyBHc3cGxB7KETEziAYDp2nWSsuIkg75jT0"
    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // MARK: - METHODS
    func getTranslation(frenchText : String, completionHandler: @escaping ((Bool, SettingsTranslation?, TranslationResult? ) -> Void)) {
        
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        
        let body = "key=\(apikeyTranslate)&q=\(frenchText)&source=fr&target=en&format=text"
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        
        task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler (false, SettingsTranslation.errorData ,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler (false, SettingsTranslation.errorReponseTranslate, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(TranslationResult.self, from: data) else {
                    completionHandler (false, SettingsTranslation.errorJson, nil)
                    return
                }
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
    }
}

enum SettingsTranslation: String {
    case errorData = "Invalid data provider"
    case errorReponseTranslate = "error Reponse Translate"
    case errorJson = "error Json"
}
