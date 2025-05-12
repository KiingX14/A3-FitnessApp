import SwiftUI

struct NewWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    @State private var workoutName = ""
    
    // Sample workout names for quick selection
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