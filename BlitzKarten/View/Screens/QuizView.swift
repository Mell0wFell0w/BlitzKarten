//
//  QuizView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import Foundation
import SwiftUI

struct QuizView: View {
    var topic: Language.Topic
    
    var body: some View {
        VStack {
            Text("Quiz on \(topic.title)")
            // Add Quiz UI here for quiz questions
        }
        .navigationTitle("Quiz \(topic.title)")
    }
}
