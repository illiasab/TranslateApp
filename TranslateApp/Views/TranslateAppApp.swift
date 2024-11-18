//
//  TranslateAppApp.swift
//  TranslateApp
//
//  Created by Ylyas Abdywahytow on 11/16/24.
//

import SwiftUI

@main
struct TranslateAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: TranslateViewModel())
        }
    }
}
