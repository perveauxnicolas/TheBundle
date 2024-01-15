//
//  Weather.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 03/01/2024.
//

import Foundation

//struct Weather {
//    var name: String
//    var mainTemperature: String
//    var weatherDescription: String
//}


struct Weather: Decodable {
    var weather: [Weathers]
    var main: Main
    var name: String
}

struct Weathers: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var temp_min: Double
    var temp_max: Double
}
