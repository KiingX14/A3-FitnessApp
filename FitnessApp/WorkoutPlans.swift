import SwiftUI

struct WorkoutPlanView: View {
    @State private var selectedLevel = "Beginner"
    @State private var selectedExercises: Set<String> = []
    @State private var generatedPlan: [String] = []
    @State private var showSummary = false

    let allExercises = [
        "Push Ups", "Mountain Climbers", "Squats", "Side Plank", "Squat", "Wall Sit", "Lunges", "Sit Ups", "Crunches", "Spider Crawl", "Plank"
    ]
    
    let timeBasedExercises: Set<String> = ["Plank", "Wall Sit", "Side Planks"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Your Workout Plan")
                .font(.title)
                .fontWeight(.bold)

            Menu {
                Button("Beginner", action: { selectedLevel = "Beginner" })
                Button("Intermediate", action: { selectedLevel = "Intermediate" })
                Button("Advanced", action: { selectedLevel = "Advanced" })
            } label: {
                Label("Difficulty: \(selectedLevel)", systemImage: "chevron.down")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }

            Text("Select Exercises")
                .font(.headline)

            List(allExercises, id: \.self) { exercise in
                HStack {
                    Text(exercise)
                    Spacer()
                    Image(systemName: selectedExercises.contains(exercise) ? "checkmark.square.fill" : "square")
                        .onTapGesture {
                            toggleExercise(exercise)
                        }
                        .foregroundColor(.blue)
                }
            }
            .frame(height: 250)

            Button("Create Plan") {
                generateWorkoutPlan()
                showSummary = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()

            NavigationLink(
                destination: WorkoutSummaryView(plan: generatedPlan, level: selectedLevel),
                isActive: $showSummary
            ) {
                EmptyView()
            }
        }
        .padding()
    }

    func toggleExercise(_ exercise: String) {
        if selectedExercises.contains(exercise) {
            selectedExercises.remove(exercise)
        } else {
            selectedExercises.insert(exercise)
        }
    }

    func generateWorkoutPlan() {
        let (reps, duration): (String, String)
        switch selectedLevel {
        case "Beginner": reps = "10 reps"; duration = "30 seconds"
        case "Intermediate": reps = "15 reps"; duration = "45 seconds"
        case "Advanced": reps = "20 reps"; duration = "60 seconds"
        default: reps = "10 reps"; duration = "30 seconds"
        }

        generatedPlan = selectedExercises.map { exercise in
            timeBasedExercises.contains(exercise) ?
                "\(exercise): \(duration)" :
                "\(exercise): \(reps)"
        }
    }
}
