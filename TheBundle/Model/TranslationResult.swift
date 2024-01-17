//
//  TranslationResult.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 17/01/2024.
//

import Foundation

struct Translations: Codable {
    var translatedText: String
}

struct DataWithTranslations: Codable {
    var translations: [Translations]
}

struct TranslationResult: Codable {
    var data: DataWithTranslations
}
