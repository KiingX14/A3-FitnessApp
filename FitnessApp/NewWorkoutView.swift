//
//  NewWorkoutView.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import SwiftUI

/// View for starting a new workout
/// Allows the user to enter a workout name or select from preset options
struct NewWorkoutView: View {
    /// Environment variable for dismissing the view
    @Environment(\.dismiss) private var dismiss
    
    /// Access to workout tracking functionality
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    
    /// Name of the workout being created
    @State private var workoutName = ""
    
    /// Sample workout names for quick selection
    private let sampleWorkouts = ["Quick HIIT", "Full Body", "Upper Body", "Lower Body", "Core Workout", "Cardio"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Details")) {
                    TextField("Workout Name", text: $workoutName)
                }
                
                Section(header: Text("Quick Select")) {
                    ForEach(sampleWorkouts, id: \.self) { workout in
                        Button(workout) {
                            workoutName = workout
                        }
                    }
                }
                
                Section {
                    Button("Start Workout") {
                        guard !workoutName.isEmpty else { return }
                        trackingManager.startWorkout(workoutName: workoutName)
                        dismiss()
                    }
                    .disabled(workoutName.isEmpty)
                }
            }
            .navigationTitle("New Workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

/// Preview provider for SwiftUI canvas
struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView()
    }
}