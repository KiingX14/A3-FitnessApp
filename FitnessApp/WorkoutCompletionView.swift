//
//  WorkoutCompletionView.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import SwiftUI

struct WorkoutCompletionView: View {
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Properties
    
    // Instead of using StateObject, take exercises as a parameter
    let exercises: [ExerciseCompletion]
    
    // Add a completion handler
    var onComplete: ((Int?, String?, MoodType?) -> Void)?
    
    // If no onComplete is provided, we'll use the shared tracking manager
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    
    @State private var userRating: Int?
    @State private var notes = ""
    @State private var selectedMood: MoodType?
    
    // MARK: - Initializers
    
    // Add a custom initializer to handle both use cases
    init(
        exercises: [ExerciseCompletion] = [],
        onComplete: ((Int?, String?, MoodType?) -> Void)? = nil
    ) {
        self.exercises = exercises
        self.onComplete = onComplete
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercises Completed")) {
                    ForEach(exercises) { exercise in
                        HStack {
                            Image(systemName: exercise.completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(exercise.completed ? .green : .gray)
                            
                            Text(exercise.exerciseName)
                            
                            Spacer()
                            
                            if let rating = exercise.difficultyRating {
                                HStack {
                                    ForEach(1...3, id: \.self) { star in
                                        Image(systemName: star <= rating ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("How was your workout?")) {
                    HStack {
                        ForEach(1...5, id: \.self) { rating in
                            Image(systemName: rating <= (userRating ?? 0) ? "star.fill" : "star")
                                .font(.title)
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    userRating = rating
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("How do you feel?")) {
                    HStack {
                        ForEach(MoodType.allCases, id: \.self) { mood in
                            VStack {
                                Image(systemName: moodIcon(for: mood))
                                    .font(.title)
                                    .foregroundColor(selectedMood == mood ? .blue : .gray)
                                Text(mood.rawValue)
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(selectedMood == mood ? Color.blue.opacity(0.1) : Color.clear)
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedMood = mood
                            }
                        }
                    }
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
                
                Section {
                    Button("Save Workout") {
                        if let onComplete = onComplete {
                            // Use the provided completion handler if available
                            onComplete(userRating, notes.isEmpty ? nil : notes, selectedMood)
                        } else {
                            // Otherwise use the shared tracking manager
                            trackingManager.completeWorkout(
                                exercises: exercises,
                                userRating: userRating,
                                notes: notes.isEmpty ? nil : notes,
                                mood: selectedMood
                            )
                        }
                        dismiss()
                    }
                }
            }
            .navigationTitle("Complete Workout")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Helper Methods
    
    private func moodIcon(for mood: MoodType) -> String {
        switch mood {
        case .energized: return "bolt.fill"
        case .good: return "hand.thumbsup.fill"
        case .neutral: return "face.smiling"
        case .tired: return "powersleep"
        case .exhausted: return "bolt.horizontal.fill"
        }
    }
}

// MARK: - Preview
struct WorkoutCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCompletionView(
            exercises: [
                ExerciseCompletion(sessionId: UUID(), exerciseName: "Push Ups", completed: true),
                ExerciseCompletion(sessionId: UUID(), exerciseName: "Squats", completed: false)
            ]
        )
    }
}