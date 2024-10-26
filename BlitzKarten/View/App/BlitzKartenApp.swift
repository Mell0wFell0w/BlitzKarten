//
//  BlitzKartenApp.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/25/24.
//

import SwiftUI
import SwiftData

@main
struct BlitzKartenApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(languageViewModel: LanguageViewModel())
        }
    }
    

}
