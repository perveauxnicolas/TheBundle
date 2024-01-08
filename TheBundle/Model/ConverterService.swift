//
//  ConverterService.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import Foundation

class ConverterService {
    
     static var shared = ConverterService()
     private init() {}
     
     private static let currencyUrl = URL(string: "http://data.fixer.io/api/latest?access_key=5ff447c427a92807c43a16e73c61691a")!
     //"http://data.fixer.io/api/latest?access_key=5ff447c427a92807c43a16e73c61691a"
     
     private var task: URLSessionDataTask?
     private var converterSession = URLSession(configuration: .default)
     
     init( converterSession: URLSession ) {
     self.converterSession = converterSession
     }
     
     func getCurrency(callback: @escaping(Bool, Currency?) -> Void) {
     var request = URLRequest(url: ConverterService.currencyUrl)
     request.httpMethod = "POST"
     let body = "access_key=5ff447c427a92807c43a16e73c61691a"
     request.httpBody = body.data(using: .utf8)
     
     
     task?.cancel()
     task = converterSession.dataTask(with: request) { (data, response, error) in
     DispatchQueue.main.async {
     guard let data = data, error == nil else {
     callback (false, nil)
     return
     }
     guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
     callback (false, nil)
     return
     }
     guard let responseJSON = try? JSONDecoder().decode([String: String].self, from: data) else {
     callback (false, nil)
     return
     }
     guard let ratesUsd = responseJSON["rates/USD"] else {
     callback (false, nil)
     return
     }
     
     let currency =  Currency(ratesUsd: ratesUsd)
     callback (true, currency)
     }
     }
     
     task?.resume()
     }
     }
     


