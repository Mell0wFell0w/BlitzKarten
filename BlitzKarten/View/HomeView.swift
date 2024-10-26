//
//  HomeView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/25/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var languageViewModel: LanguageViewModel
    
    // State to control navigation path and selected topic
    @State private var path: [NavigationDestination] = []
    
    // Enum to manage navigation destinations
    enum NavigationDestination: Hashable {
        case lesson(Language.Topic)
        case study(Language.Topic)
        case quiz(Language.Topic)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List(languageViewModel.topics) { topic in
                VStack(alignment: .leading) {
                    Text(topic.title)
                        .font(.headline)
                    
                    // Toggle for marking lesson as read
                    Toggle(isOn: Binding(
                        get: { languageViewModel.progress(for: topic.title).lessonRead },
                        set: { _ in languageViewModel.toggleLessonRead(for: topic.title) }
                    )) {
                        Text("Lesson read")
                    }
                    
                    // Separate buttons for Lesson, Study, and Quiz with programmatic navigation
                    HStack(spacing: 16) {
                        Button("Lesson") {
                            path.append(.lesson(topic))
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Study") {
                            path.append(.study(topic))
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Quiz") {
                            path.append(.quiz(topic))
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.vertical)
            }
            .listStyle(.plain)
            .navigationTitle("Learn \(languageViewModel.languageName)!")
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .lesson(let topic):
                    LessonView(htmlFileName: topic.htmlFileName)
                case .study(let topic):
                    StudyView(topic: topic)
                case .quiz(let topic):
                    QuizView(topic: topic)
                }
            }
        }
    }
}

#Preview {
    HomeView(languageViewModel: LanguageViewModel())
}
