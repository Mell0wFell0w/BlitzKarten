//
//  StudyView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import Foundation
import SwiftUI

struct StudyView: View {
    var topic: Language.Topic
    
    var body: some View {
        VStack {
            Text("Study \(topic.title)")
            // Add Flashcard UI here for vocabulary
        }
        .navigationTitle("Study \(topic.title)")
    }
}
