//
//  WeatherResult.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 19/01/2024.
//

import Foundation


struct WeatherResult: Codable {
    var weather: [Weather]
    var main: Main
    var name: String
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var feels_like : Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct Coord : Codable {
    var lon: Double
    var lat : Double
}
