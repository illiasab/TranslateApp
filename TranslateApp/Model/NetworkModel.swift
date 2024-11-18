//
//  NetworkModel.swift
//  TranslateApp
//
//  Created by Ylyas Abdywahytow on 11/16/24.
//


import SwiftUI

// MARK: - Translation Request Struct
struct TranslationRequest: Codable {
    let q: String
    let source: String
    let target: String
    let format: String
}

// MARK: - Translation Response Struct
struct TranslationResponse: Codable {
    let data: TranslationData
}

struct TranslationData: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let translatedText: String
}

// MARK: - API Client
class GoogleTranslateAPI {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func translateText(
        text: String,
        sourceLanguage: String,
        targetLanguage: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let urlString = "https://translation.googleapis.com/language/translate/v2?key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let requestPayload = TranslationRequest(
            q: text,
            source: sourceLanguage,
            target: targetLanguage,
            format: "text"
        )
        
        do {
            let requestData = try JSONEncoder().encode(requestPayload)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No Data", code: -2, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)
                    if let translatedText = decodedResponse.data.translations.first?.translatedText {
                        completion(.success(translatedText))
                    } else {
                        completion(.failure(NSError(domain: "No Translation", code: -3, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
