//
//  TranslateViewModel.swift
//  TranslateApp
//
//  Created by Ylyas Abdywahytow on 11/16/24.
//

import Foundation
import Combine

class TranslateViewModel: ObservableObject {
     @Published var russianText: String = ""
     @Published var errorMessage: String?
     @Published var ru: String = "Русский"
     @Published var en: String = "Английский"
     @Published var isLoading: Bool = false
     @Published var languages: [String: String] = [:]
     @Published var sourceLanguage: String = "en"
     @Published var targetLanguage: String = "ru"
     @Published var  promptText: String =  "Enter text"
     @Published var  promptText2: String = "Перевести текст"
     @Published var  navTitle: String = "Translate"
     @Published var  switchLanguage: String = "arrow.up.arrow.down"
     @Published var englishText: String = "" {
           didSet {
               translateText()
           }
       }

       private let translateAPI = GoogleTranslateAPI(apiKey: "AIzaSyDacHVWkgGCGPA5nPi4urTxpAfAXtCy3aM")
       
       func translateText() {
           guard !englishText.isEmpty else { return }

           errorMessage = nil
           isLoading = true

           translateAPI.translateText(
               text: englishText,
               sourceLanguage: sourceLanguage,
               targetLanguage: targetLanguage
           ) { [weak self] result in
               DispatchQueue.main.async {
                   self?.isLoading = false
                   switch result {
                   case .success(let translatedText):
                       self?.russianText = translatedText
                   case .failure(let error):
                       self?.errorMessage = "Error: \(error.localizedDescription)"
                   }
               }
           }
       }
//MARK: - Switch Languages
       func switchLanguages() {
           (sourceLanguage, targetLanguage) = (targetLanguage, sourceLanguage)
           if !englishText.isEmpty || !russianText.isEmpty {
               (englishText, russianText) = (russianText, englishText)
           }
       }
   }
