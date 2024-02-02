//
//  WeatherService.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 03/01/2024.
//

import Foundation


class WeatherService {
    
    // MARK: - PROPERTIES
    static var shared = WeatherService()
    
    private let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=paris&appid=64bbd9f8c871bd0c0734b4775075cd98&units=metric")!
    private let weatherUrlB = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=new york&appid=64bbd9f8c871bd0c0734b4775075cd98&units=metric")!
    
    private var task: URLSessionDataTask?
    private var weatherSession: URLSession
    private var weatherSessionB: URLSession
    
    init(weatherSession: URLSession = URLSession(configuration: .default), weatherSessionB: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
        self.weatherSessionB = weatherSessionB
    }
    
    // MARK: - METHODS
    func getWeather( completionHandler: @escaping ((Bool, SettingsWeather?, WeatherResult? ) -> Void)) {
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "GET"
        
        task?.cancel()
        
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler (false, SettingsWeather.errorData,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler (false, SettingsWeather.errorReponseWeather, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(WeatherResult.self, from: data) else {
                    completionHandler (false, SettingsWeather.errorJson, nil)
                    return
                }
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
    }
    
    func getWeatherB( completionHandler: @escaping ((Bool, SettingsWeather?, WeatherResultB? ) -> Void)) {
        var request = URLRequest(url: weatherUrlB)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = weatherSessionB.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler (false, SettingsWeather.errorData,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler (false, SettingsWeather.errorReponseWeather, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(WeatherResultB.self, from: data) else {
                    completionHandler (false, SettingsWeather.errorJson, nil)
                    return
                }
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
    }
    
}

enum SettingsWeather: String {
    case errorData = "Invalid data provider"
    case errorReponseWeather = "error Reponse Weather"
    case errorJson = "error Json"
}
