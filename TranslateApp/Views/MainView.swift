//
//  ContentView.swift
//  TranslateApp
//
//  Created by Ylyas Abdywahytow on 11/16/24.
//



import SwiftUI
struct MainView: View {
    @ObservedObject var viewModel: TranslateViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // MARK: - Top TextField
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button(action: {}) {
                        Text(viewModel.sourceLanguage == viewModel.sourceLanguage  ? viewModel.en : viewModel.ru)
                                .padding(8)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing, 20)
                    }

                    TextField(viewModel.promptText, text: $viewModel.englishText)
                        .padding()
                        .frame(width: 370, height: 200)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                }

                // MARK: - Translate/Switch Languages Button
                Button(action: {
                    viewModel.switchLanguages()
                }) {
                    Image(systemName: viewModel.switchLanguage)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
                .disabled(viewModel.isLoading)

                // MARK: - Bottom TextField
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button(action: {}) {
                        Text(viewModel.targetLanguage == viewModel.targetLanguage ? viewModel.ru : viewModel.en)
                                .padding(8)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing, 20)
                    }

                    TextField(viewModel.promptText2, text: $viewModel.russianText)
                        .padding()
                        .frame(width: 370, height: 200)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                        .disabled(true)
                }

                // MARK: - Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle(viewModel.navTitle)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    MainView(viewModel: TranslateViewModel())
}
