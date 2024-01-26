//
//  WeatherResultB.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 25/01/2024.
//

import Foundation


struct WeatherResultB: Codable {
    var weather: [Weather]
    var main: Main
    var name: String
}

struct WeatherB: Codable {
    var description: String
}

struct MainB: Codable {
    var temp: Double
}

