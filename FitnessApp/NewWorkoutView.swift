

import SwiftUI

// View for starting a new workout
struct NewWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    @State private var workoutName = ""
    
    private let sampleWorkouts = ["Push Ups", "Mountain Climbers", "Squats", "Side Plank", "Squat", "Wall Sit", "Lunges", "Sit Ups", "Crunches", "Spider Crawl", "Plank"]
    
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
                        _ = trackingManager.startWorkout(workoutName: workoutName)
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
