//
//  ConvertionService.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import Foundation



class ConvertionService {
    
    static var shared = ConvertionService()
    private init() {}
    
    private let currencyUrl = URL(string: "http://data.fixer.io/api/latest")!
    private let apikeyConvertion = "5ff447c427a92807c43a16e73c61691a"
    private var task: URLSessionDataTask?
    private var convertionSession = URLSession(configuration: .default)
    
    init( convertionSession: URLSession ) {
        self.convertionSession = convertionSession
    }
    
    func getConvertion(currencyA: Double, completionHandler: @escaping ((Bool, Settings?, ConvertionResult? ) -> Void)) {
        
        var request = URLRequest(url: currencyUrl )
        request.httpMethod = "POST"
        
        let body = "access_key=\(apikeyConvertion)"
        request.httpBody = body.data(using: .utf8)
        
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
    
    enum Settings: String {
        case errorData = "Invalid data provider"
        case errorReponseTranslate = "error Reponse Translate"
        case errorJson = "error Json"
    }
    
}
