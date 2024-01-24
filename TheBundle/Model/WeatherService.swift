//
//  WeatherService.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 03/01/2024.
//

import Foundation

class WeatherService {
    
    static var shared = WeatherService()
    private init() {}
    
    private let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    private let apikeyWeather = "64bbd9f8c871bd0c0734b4775075cd98"
    private var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)
    
    init( weatherSession: URLSession ) {
        self.weatherSession = weatherSession
    }
    
    
    func getWeather( completionHandler: @escaping ((Bool, Settings?, WeatherResult? ) -> Void)) {
        
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"
        
        let body = "appid=\(apikeyWeather)&q=paris&units=metric"
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler (false, Settings.errorData,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler (false, Settings.errorReponseTranslate, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(WeatherResult.self, from: data) else {
                    completionHandler (false, Settings.errorJson, nil)
                    return
                }
                /*       guard let name = result["weatherResult.name"],
                 let temperature = result["weatherResult.main.temp"],
                 let descritpion = result["weatherResult.weather[2].description"] else {
                 completionHandler (false, Settings.errorJson2, nil)
                 return
                 }
                 let weatherResult = WeatherResult(name: name,temperature: temperature, descritpion: descritpion ) */
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
    }
    enum Settings: String {
        case errorData = "Invalid data provider"
        case errorReponseTranslate = "error Reponse Translate"
        case errorJson = "error Json"
        case errorJson2 = "error 2 Json"
    }
    
    
    
}
