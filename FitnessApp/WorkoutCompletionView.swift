//
//  WorkoutCompletionView.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import SwiftUI

/// View for completing a workout
/// Allows the user to mark exercises as completed, rate the workout,
/// select their mood, and add notes
struct WorkoutCompletionView: View {
    /// Environment variable for dismissing the view
    @Environment(\.dismiss) private var dismiss
    
    /// Access to workout tracking functionality
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    
    /// User's rating of the workout (1-5 stars)
    @State private var userRating: Int?
    
    /// User's notes about the workout
    @State private var notes = ""
    
    /// User's mood after the workout
    @State private var selectedMood: MoodType?
    
    /// List of exercises with completion status
    @State private var exercises: [ExerciseCompletion] = []
    
    /// Sample exercises - in a real app, you'd get these from your exercise library
    /// This would be replaced with data from the ExerciseLibrary component
    private let sampleExercises = ["Push-ups", "Squats", "Lunges", "Plank", "Jumping Jacks"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercises Completed")) {
                    ForEach(exercises.indices, id: \.self) { index in
                        HStack {
                            Button(action: { exercises[index].completed.toggle() }) {
                                Image(systemName: exercises[index].completed ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(exercises[index].completed ? .green : .gray)
                            }
                            
                            Text(exercises[index].exerciseName)
                            
                            Spacer()
                            
                            // Difficulty rating
                            HStack {
                                ForEach(1...3, id: \.self) { rating in
                                    Image(systemName: rating <= (exercises[index].difficultyRating ?? 0) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .onTapGesture {
                                            exercises[index].difficultyRating = rating
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
                        trackingManager.completeWorkout(
                            exercises: exercises,
                            userRating: userRating,
                            notes: notes.isEmpty ? nil : notes,
                            mood: selectedMood
                        )
                        dismiss()
                    }
                }
            }
            .navigationTitle("Complete Workout")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Initialize exercises list
                exercises = sampleExercises.map { exercise in
                    ExerciseCompletion(
                        sessionId: trackingManager.currentSession?.id ?? UUID(),
                        exerciseName: exercise
                    )
                }
            }
        }
    }
    
    /// Returns an SF Symbol name for each mood type
    /// - Parameter mood: The mood to get an icon for
    /// - Returns: SF Symbol name representing the mood
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

/// Preview provider for SwiftUI canvas
struct WorkoutCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        // Note: This preview may not work properly since it requires an active workout
        WorkoutCompletionView()
    }
}
