//
//  LanguageViewModel.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/25/24.
//

import Foundation

@Observable class LanguageViewModel  {
    // MARK: - Props
    
    private var lessonPlan: LessonPlan = GermanLessonPlan(progress: [])
    
    // MARK: - Model Access
    var languageName: String {
        lessonPlan.languageName
    }
    
    var topics: [Language.Topic] {
        lessonPlan.topics
    }
    
    func progress(for title: String) -> Language.Progress {
        if let progressRecord = lessonPlan.progress.first(where: {$0.topicTitle == title}) {
            return progressRecord
        }
        
        let progressRecord = Language.Progress(topicTitle: title)
        
        lessonPlan.progress.append(progressRecord)
        
        return progressRecord
    }
    
    // MARK: - User intents
    
    func toggleLessonRead(for title: String) {
        lessonPlan.toggleLessonRead(for: title)
    }
    
    // MARK: - Private helpers
}
