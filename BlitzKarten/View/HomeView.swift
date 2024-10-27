import SwiftUI

struct HomeView: View {
    var languageViewModel: LanguageViewModel
    
    @State private var path: [NavigationDestination] = []
    
    enum NavigationDestination: Hashable {
        case lesson(Language.Topic)
        case study(Language.Topic)
        case quiz(Language.Topic)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                //MARK: - Main content
                List(languageViewModel.topics) { topic in
                    VStack(alignment: .leading, spacing: 16) {
                        Text(topic.title)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Button(action: {
                            languageViewModel.toggleLessonRead(for: topic.title)
                        }) {
                            HStack {
                                Text("Mark Lesson as Read")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: languageViewModel.progress(for: topic.title).lessonRead ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(languageViewModel.progress(for: topic.title).lessonRead ? .green : .gray)
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding(.vertical, 2)
                        
                        Button(action: {
                            languageViewModel.toggleVocabStudied(for: topic.title)
                        }) {
                            HStack {
                                Text("Mark flash cards as studied")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: languageViewModel.progress(for: topic.title).vocabularyStudied ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(languageViewModel.progress(for: topic.title).vocabularyStudied ? .green : .gray)
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding(.vertical, 2)
                        
                        Button(action: {
                            languageViewModel.toggleQuizTaken(for: topic.title)
                        }) {
                            HStack {
                                Text("Mark Quiz as taken")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: languageViewModel.progress(for: topic.title).quizPassed ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(languageViewModel.progress(for: topic.title).quizPassed ? .green : .gray)
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding(.vertical, 2)
                        
                        HStack(spacing: 20) {
                            Button("Lesson") {
                                path.append(.lesson(topic))
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            
                            Button("Study") {
                                path.append(.study(topic))
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            
                            Button("Quiz") {
                                path.append(.quiz(topic))
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                        }
                        .padding(.vertical, 8)
                    }
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(1), Color.blue.opacity(0.6)]),
                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(12) // Rounded corners for each section
                }
                .padding(.vertical, 4)
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
