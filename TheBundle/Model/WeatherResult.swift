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
    var description: String
}

struct Main: Codable {
    var temp: Double
}
