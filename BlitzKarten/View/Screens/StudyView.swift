//
//  StudyView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import Foundation
import SwiftUI

struct StudyView: View {
    @State private var selectedSet = "Translation" // Default study set
    @State private var selectedTab = 0
    @State private var isFlipped = false           // Tracks flip state
    var topic: Language.Topic

    // List of study set options
    private let studySets = ["Translation", "Present Tense", "Imperfect Tense", "Past Participle"]

    var body: some View {
        VStack {
            // Segmented control for study set selection
            Picker("Study Set", selection: $selectedSet) {
                ForEach(studySets, id: \.self) { set in
                    Text(set)
                }
            }
            .padding()

            // TabView for vocabulary words in the selected study set
            TabView(selection: $selectedTab) {
                ForEach(topic.vocabulary, id: \.self) { term in
                    VStack {
                        // Flip Card
                        FlipCard(isFlipped: $isFlipped, frontText: term.infinitive, backText: getTermText(for: term))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    isFlipped.toggle() // Flip the card
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .padding()
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .navigationTitle(topic.title)
    }

    // Helper function to get the correct text based on the selected study set
    private func getTermText(for term: Language.Term) -> String {
        switch selectedSet {
        case "Translation":
            return term.translation
        case "Present Tense":
            return term.presentTense
        case "Imperfect Tense":
            return term.imperfectTense
        case "Past Participle":
            return term.pastParticiple
        default:
            return term.translation
        }
    }
}

// Flip Card View
struct FlipCard: View {
    @Binding var isFlipped: Bool
    var frontText: String
    var backText: String

    // Computed property to check if the back side should be visible
    private var backOpacity: Double {
        isFlipped ? 1.0 : 0.0
    }
    
    private var frontOpacity: Double {
        isFlipped ? 0.0 : 1.0
    }

    var body: some View {
        ZStack {
            // Back of the card
            Text(backText)
                .font(.title)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .opacity(backOpacity) // Hide the back text initially

            // Front of the card
            Text(frontText)
                .font(.largeTitle)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .opacity(frontOpacity) // Hide the front text when flipped
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.6), value: isFlipped)
    }
}

#Preview {
    HomeView(languageViewModel: LanguageViewModel())
}
