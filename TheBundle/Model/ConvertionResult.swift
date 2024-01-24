//
//  ConvertionResult.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 20/01/2024.
//

import Foundation

struct ConvertionResult: Codable {
    let success: Bool
    let timestamp: TimeInterval
    let base : String
    let date: String
    let rates: [String: Double]
}
