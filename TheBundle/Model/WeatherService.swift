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
    
    private static let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=paris&appid=64bbd9f8c871bd0c0734b4775075cd98&units=metric")!
    
    private var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)
    
    init( weatherSession: URLSession ) {
        self.weatherSession = weatherSession
    }
    
    func getweather(callback: @escaping(Bool, Weather?) -> Void) {
        var request = URLRequest(url: WeatherService.weatherUrl)
        request.httpMethod = "POST"
        let body = "q=paris&appid=64bbd9f8c871bd0c0734b4775075cd98&units=metric"
        request.httpBody = body.data(using: .utf8)
        
        
        task?.cancel()
        task = weatherSession.dataTask(with: request) { (data, response, error) in
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
                guard let name = responseJSON["name"],
                      let weatherDescription = responseJSON["weather/description"],
                      let mainTemperature = responseJSON["main/temp"] else {
                    callback (false, nil)
                    return
                }
                
                let weather = Weather(name: name, mainTemperature: mainTemperature, weatherDescription: weatherDescription)
                callback (true, weather)
            }
        }
        
        task?.resume()
    }
}

