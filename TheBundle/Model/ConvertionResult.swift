//
//  ConvertionResult.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 20/01/2024.
//

import Foundation

struct ConvertionResult: Codable {
    var base: String
    var date: String
    var rates: Rates
}

struct Rates: Codable {
    var USD: Double
}
