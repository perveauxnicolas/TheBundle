//
//  Translations.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 14/01/2024.
//

import Foundation

struct Translations: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [TranslationText]
}

struct TranslationText: Decodable {
    let translatedText: String
}
