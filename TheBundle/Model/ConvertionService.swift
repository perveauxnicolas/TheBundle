//
//  ConvertionService.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import Foundation
import UIKit



class ConvertionService  {
    
    // MARK: - PROPERTIES
    static var shared = ConvertionService()
    //private init() {}
    private let currencyUrl = URL(string: "http://data.fixer.io/api/latest?access_key=5ff447c427a92807c43a16e73c61691a")!
    private var task: URLSessionDataTask?
    private var convertionSession : URLSession
    
    init(convertionSession: URLSession = URLSession(configuration: .default)) {
        self.convertionSession = convertionSession
    }
    
    // MARK: - METHODS
    func getConvertion(currencyA: Double, completionHandler: @escaping ((Bool, Settings?, ConvertionResult?) -> Void)) {
        var request = URLRequest(url: currencyUrl )
        request.httpMethod = "GET"
        
        task?.cancel()
        task = convertionSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler (false, Settings.errorData,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler (false, Settings.errorReponseTranslate, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(ConvertionResult.self, from: data) else {
                    completionHandler (false, Settings.errorJson, nil)
                    return
                }
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
    }
    
}

enum Settings: String {
    case errorData = "Invalid data provider"
    case errorReponseTranslate = "error Reponse Translate"
    case errorJson = "error Json"
}
