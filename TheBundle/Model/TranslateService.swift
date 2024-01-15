//
//  TranslateService.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 10/01/2024.
//

import Foundation

class TranslateService {
    
    static var shared = TranslateService()
    private init() {}
    
    private static let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBHc3cGxB7KETEziAYDp2nWSsuIkg75jT0")!
    /*  "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBHc3cGxB7KETEziAYDp2nWSsuIkg75jT0&q=\(frenchText)&target=en&source=fr")!
     */
    
    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)
    
    init( translateSession: URLSession ) {
        self.translateSession = translateSession
    }
    
    
    func getTranslate(frenchText: String ,callback: @escaping(Bool, Translations?) -> Void) {
        var request = URLRequest(url: TranslateService.translateUrl )
        request.httpMethod = "POST"
        
        let body = "&q=\(frenchText)&target=en&source=fr"
        request.httpBody = body.data(using: .utf8)
        
        
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
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
                guard let text = responseJSON["data.translations[0].translatedText"] else {
                    callback (false, nil)
                    return
                }
                
      //          let translations = Translations(translation.data.translations[0].translatedTexe: text)
       //       callback (true, translations)
            }
        }
        
        task?.resume()
    }
}


//translations.data.translations[0].translatedText: textToTranslate
