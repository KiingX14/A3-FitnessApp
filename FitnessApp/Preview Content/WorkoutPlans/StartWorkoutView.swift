//
//  StartWorkoutView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct StartWorkoutView: View {
    let plan: [String]
    
    // Add these properties for workout tracking integration
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    @State private var workoutExercises: [WorkoutExercise] = []
    @State private var elapsedTime = 0
    @State private var timer: Timer?
    @State private var showCompletionSheet = false
    @State private var workoutName: String = "Custom Workout"
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            // Timer display
            HStack {
                Image(systemName: "clock")
                    .font(.headline)
                Text(formatTime(elapsedTime))
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
            }
            .padding()
            
            // Progress bar
            ProgressView(value: progressValue)
                .padding(.horizontal)
            
            Text("\(completedExercises) of \(workoutExercises.count) exercises completed")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Exercise list with completion tracking
            List {
                ForEach(workoutExercises.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(workoutExercises[index].name)
                                .font(.headline)
                            if !workoutExercises[index].requirement.isEmpty {
                                Text(workoutExercises[index].requirement)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            workoutExercises[index].isCompleted.toggle()
                        }) {
                            Image(systemName: workoutExercises[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                                .foregroundColor(workoutExercises[index].isCompleted ? .green : .gray)
                        }
                    }
                }
            }
            
            // Complete workout button
            Button(action: {
                endWorkout()
            }) {
                Text("Complete Workout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Workout In Progress")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    cancelWorkout()
                }
            }
        }
        .onAppear {
            // Initialize the workout
            setupWorkout()
        }
       .sheet(isPresented: $showCompletionSheet) {
        WorkoutCompletionView(
        exercises: convertToExerciseCompletions(),
        onComplete: { rating, notes, mood in
            // Complete the workout in tracking manager
            trackingManager.completeWorkout(
                exercises: convertToExerciseCompletions(),
                userRating: rating,
                notes: notes,
                mood: mood
            )
            
            // Go back to previous screen
            presentationMode.wrappedValue.dismiss()
        }
    )
}
    
    // MARK: - Helper Properties
    
    private var completedExercises: Int {
        workoutExercises.filter { $0.isCompleted }.count
    }
    
    private var progressValue: Double {
        guard workoutExercises.count > 0 else { return 0 }
        return Double(completedExercises) / Double(workoutExercises.count)
    }
    
    // MARK: - Methods
    
    private func setupWorkout() {
        // Convert plan to workout exercises
        workoutExercises = convertPlanToWorkoutExercises(plan)
        
        // Start the workout in tracking manager
        trackingManager.startWorkout(workoutName: workoutName)
        
        // Start the timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }
    
    private func endWorkout() {
        timer?.invalidate()
        timer = nil
        showCompletionSheet = true
    }
    
    private func cancelWorkout() {
        timer?.invalidate()
        timer = nil
        
        // Cancel in tracking manager
        trackingManager.cancelWorkout()
        
        // Go back
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveWorkout(rating: Int?, notes: String?, mood: MoodType?) {
        // Complete the workout in tracking manager
        trackingManager.completeWorkout(
            exercises: convertToExerciseCompletions(),
            userRating: rating,
            notes: notes,
            mood: mood
        )
        
        // Go back
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    private func convertPlanToWorkoutExercises(_ plan: [String]) -> [WorkoutExercise] {
        return plan.map { exerciseString in
            // Parse the exercise string
            // Assume format like "Push Ups: 10 reps" or just "Push Ups"
            let components = exerciseString.split(separator: ":")
            let name = String(components[0]).trimmingCharacters(in: .whitespaces)
            
            let requirement = components.count > 1 ? 
                String(components[1]).trimmingCharacters(in: .whitespaces) : ""
            
            return WorkoutExercise(name: name, requirement: requirement)
        }
    }
    
    private func convertToExerciseCompletions() -> [ExerciseCompletion] {
        return workoutExercises.map { exercise in
            ExerciseCompletion(
                sessionId: trackingManager.currentSession?.id ?? UUID(),
                exerciseName: exercise.name,
                completed: exercise.isCompleted
            )
        }
    }
}

// Define WorkoutExercise if it doesn't exist yet
struct WorkoutExercise: Identifiable {
    let id = UUID()
    let name: String
    let requirement: String
    var isCompleted = false
    }
}