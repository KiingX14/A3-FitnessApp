import SwiftUI

struct StartWorkoutView: View {
    let plan: [String]

    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    @State private var workoutExercises: [WorkoutExercise] = []
    @State private var elapsedTime = 0
    @State private var timer: Timer?
    @State private var showCompletionSheet = false
    @State private var workoutName: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            // Workout name input
            VStack(alignment: .leading, spacing: 6) {
                Text("Workout Name")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                TextField("Enter workout name", text: $workoutName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
            }
            .padding(.horizontal)

            // Timer
            HStack {
                Image(systemName: "clock")
                    .font(.headline)
                Text(formatTime(elapsedTime))
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
            }
            .padding(.top)

            // Progress
            ProgressView(value: progressValue)
                .padding(.horizontal)

            Text("\(completedExercises) of \(workoutExercises.count) exercises completed")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Exercise list
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(workoutExercises.indices, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(workoutExercises[index].name)
                                    .font(.headline)
                                    .foregroundColor(.black)
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
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                }
                .padding(.horizontal)
            }

            // Complete button
            Button(action: {
                endWorkout()
            }) {
                Text("Complete Workout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
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
            setupWorkout()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .sheet(isPresented: $showCompletionSheet) {
            WorkoutCompletionView(
                exercises: convertToExerciseCompletions(),
                onComplete: { rating, notes, mood in
                    trackingManager.completeWorkout(
                        exercises: convertToExerciseCompletions(),
                        userRating: rating,
                        notes: notes,
                        mood: mood
                    )
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }

    var completedExercises: Int {
        workoutExercises.filter { $0.isCompleted }.count
    }

    var progressValue: Double {
        guard workoutExercises.count > 0 else { return 0 }
        return Double(completedExercises) / Double(workoutExercises.count)
    }

    func setupWorkout() {
        workoutExercises = convertPlanToWorkoutExercises(plan)
        let nameToUse = workoutName.isEmpty ? "Custom Workout" : workoutName
        trackingManager.startWorkout(workoutName: nameToUse)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }

    func endWorkout() {
        timer?.invalidate()
        timer = nil
        showCompletionSheet = true
    }

    func cancelWorkout() {
        timer?.invalidate()
        timer = nil
        trackingManager.cancelWorkout()
        presentationMode.wrappedValue.dismiss()
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    func convertPlanToWorkoutExercises(_ plan: [String]) -> [WorkoutExercise] {
        return plan.map { exerciseString in
            let components = exerciseString.split(separator: ":")
            let name = String(components[0]).trimmingCharacters(in: .whitespaces)
            let requirement = components.count > 1 ? String(components[1]).trimmingCharacters(in: .whitespaces) : ""
            return WorkoutExercise(name: name, requirement: requirement)
        }
    }

    func convertToExerciseCompletions() -> [ExerciseCompletion] {
        return workoutExercises.map { exercise in
            ExerciseCompletion(
                sessionId: trackingManager.currentSession?.id ?? UUID(),
                exerciseName: exercise.name,
                completed: exercise.isCompleted
            )
        }
    }
}

struct WorkoutExercise: Identifiable {
    let id = UUID()
    let name: String
    let requirement: String
    var isCompleted = false
}
