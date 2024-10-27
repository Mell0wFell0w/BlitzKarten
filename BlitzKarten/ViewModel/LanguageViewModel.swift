//
//  LanguageViewModel.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/25/24.
//

import Foundation

class LanguageViewModel: ObservableObject {
    // MARK: - Properties
    
    // MARK: - Initializer
    private var lessonPlan: LessonPlan = GermanLessonPlan()
    
    
    // MARK: - Model Access
    var languageName: String {
        lessonPlan.languageName
    }
    
    var topics: [Language.Topic] {
        lessonPlan.topics
    }
    
    func progress(for title: String) -> Language.Progress {
        if let progressRecord = lessonPlan.progress.first(where: { $0.topicTitle == title }) {
            return progressRecord
        }
        
        let progressRecord = Language.Progress(topicTitle: title)
        
        lessonPlan.progress.append(progressRecord)
        
        return progressRecord
    }
    
    // MARK: - User Intents
    func toggleLessonRead(for title: String) {
        lessonPlan.toggleLessonRead(for: title)
    }
    
    func toggleVocabStudied(for title: String) {
        lessonPlan.toggleVocabStudied(for: title)
    }
    
    func toggleQuizTaken(for title: String) {
        lessonPlan.toggleQuizTaken(for: title)
    }
}
