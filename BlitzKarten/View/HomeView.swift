//
//  HomeView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/25/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    var languageViewModel: LanguageViewModel
    
    var body: some View {
        NavigationStack {
            List(languageViewModel.topics) { topic in
                VStack(alignment: .leading) {
                    Text(topic.title)
                        .font(.headline)
                    Button {
                        languageViewModel.toggleLessonRead(for: topic.title)
                    } label: {
                        Text("Lesson read: \(languageViewModel.progress(for: topic.title).lessonRead)")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Learn \(languageViewModel.languageName)!")
        }
    }
}

#Preview {
    HomeView(languageViewModel: LanguageViewModel())
}
