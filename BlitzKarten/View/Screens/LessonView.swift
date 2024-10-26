//
//  LessonView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import Foundation
import SwiftUI

struct LessonView: View {
    var topic: Language.Topic
    
    var body: some View {
        ScrollView {
            Text(topic.lessonText)
                .padding()
                .font(.body)
        }
        .navigationTitle(topic.title)
    }
}

