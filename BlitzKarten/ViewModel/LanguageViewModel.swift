//
//  LanguageViewModel.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/25/24.
//

import Foundation

class LanguageViewModel: ObservableObject {
    // MARK: - Properties
    
    private var lessonPlan: GermanLessonPlan  // Directly use the concrete type
    
    // Track progress as an independent @Published property
    @Published private(set) var progress: [Language.Progress]
    
    // MARK: - Initializer
    init() {
        let initialPlan = GermanLessonPlan(progress: [])
        self.lessonPlan = initialPlan
        self.progress = initialPlan.progress
    }
    
    // MARK: - Model Access
    var languageName: String {
        lessonPlan.languageName
    }
    
    var topics: [Language.Topic] {
        lessonPlan.topics
    }
    
    // Returns the progress for a specific topic title, creating a new record if one doesn't exist
    func progress(for title: String) -> Language.Progress {
        if let progressRecord = progress.first(where: { $0.topicTitle == title }) {
            return progressRecord
        }
        
        // Create and append a new progress record if not found
        let newProgressRecord = Language.Progress(topicTitle: title)
        progress.append(newProgressRecord)
        lessonPlan.progress.append(newProgressRecord) // Sync with lessonPlan
        return newProgressRecord
    }
    
    // MARK: - User Intents
    
    // Toggle lesson read state and update both progress and lessonPlan
    func toggleLessonRead(for title: String) {
        objectWillChange.send()  // Notify views of any changes
        
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].lessonRead.toggle()
            lessonPlan.progress[index].lessonRead = progress[index].lessonRead // Sync with lessonPlan
        } else {
            // If not found, create a new progress record
            let newProgress = Language.Progress(topicTitle: title, lessonRead: true)
            progress.append(newProgress)
            lessonPlan.progress.append(newProgress)  // Sync with lessonPlan
        }
    }
}


