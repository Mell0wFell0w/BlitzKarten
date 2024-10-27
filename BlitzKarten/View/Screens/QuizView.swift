//
//  QuizView.swift
//  BlitzKarten
//
//  Created by Matt Cooper on 10/26/24.
//

import SwiftUI

struct QuizView: View {
    
    //MARK: - Initializers
    var topic: Language.Topic
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var bonusPoints = 0
    @State private var elapsedTime = 0
    @State private var timeRemaining = 20
    @State private var timerActive = false
    @State private var showAnswerFeedback = false
    @State private var isCorrect = false
    @State private var highScore = 0
    @State private var showingScore = false
    @State private var currentChoices: [String] = []
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //MARK: - Body
    var body: some View {
        VStack {
            Text("Quiz on \(topic.title)")
                .font(.largeTitle)
                .padding()
            
            Text("Score: \(score)")
                .font(.title2)
                .padding()
            
            ProgressView(value: Double(timeRemaining), total: 20)
                .progressViewStyle(LinearProgressViewStyle())
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .padding()
                .onReceive(timer) { _ in
                    if timerActive && timeRemaining > 0 {
                        timeRemaining -= 1
                        elapsedTime += 1
                    } else {
                        timerActive = false
                    }
                }

            VStack {
                if showAnswerFeedback {
                    Text(isCorrect ? "🎉 Correct!" : "❌ Wrong! Correct answer: \(getCorrectAnswer())")
                        .font(.title2)
                        .foregroundColor(isCorrect ? .green : .red)
                        .padding()
                } else {
                    VStack {
                        Text("What is the translation for")
                            .font(.title2)
                            .padding(.bottom, 2)
                        
                        Text(topic.vocabulary[currentQuestionIndex].infinitive)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .modifier(ShakeEffect(shake: !isCorrect))
                    
                    ForEach(currentChoices, id: \.self) { choice in
                        Button(action: {
                            checkAnswer(choice)
                        }) {
                            Text(choice)
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            
            if !showAnswerFeedback {
                Button("Skip Question") {
                    goToNextQuestion()
                }
                .padding()
            }
        }
        .onAppear {
            startNewQuestion()
        }
    }
    
    //MARK: - Helper functions
    private func startNewQuestion() {
        timerActive = true
        timeRemaining = 20
        elapsedTime = 0
        showAnswerFeedback = false
        currentChoices = getAnswerChoices()
    }
    
    private func getAnswerChoices() -> [String] {
        
        // Set new answer choices randomly for each question
        let correctAnswer = topic.vocabulary[currentQuestionIndex].translation
        var choices = topic.vocabulary.map { $0.translation }.filter { $0 != correctAnswer }
        choices = Array(choices.prefix(3))
        choices.append(correctAnswer)
        return choices.shuffled()
    }
    
    private func getCorrectAnswer() -> String {
        return topic.vocabulary[currentQuestionIndex].translation
    }
    
    private func checkAnswer(_ answer: String) {
        timerActive = false
        if answer == getCorrectAnswer() {
            isCorrect = true
            let questionScore = 10
            bonusPoints = max(0, (20 - elapsedTime) / 2)
            score += questionScore + bonusPoints
        } else {
            isCorrect = false
        }
        showAnswerFeedback = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            goToNextQuestion()
        }
    }
    
    // To keep track of the user's score
    private func goToNextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex < topic.vocabulary.count {
            startNewQuestion()
        } else {
            showingScore = true
            highScore = max(highScore, score)
            currentQuestionIndex = 0
            score = 0
        }
    }
}

// Not working / NEEDSWORK
struct ShakeEffect: GeometryEffect {
    var shake: Bool
    var animatableData: CGFloat {
        get { shake ? 1 : 0 }
        set {}
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: shake ? -10 : 0, y: 0))
    }
}


#Preview {
    HomeView(languageViewModel: LanguageViewModel())
}
