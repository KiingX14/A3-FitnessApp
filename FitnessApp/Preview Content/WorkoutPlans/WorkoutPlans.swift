//
//  WorkoutPlans.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct WorkoutPlanView: View {
    @State private var selectedLevel = "Beginner"
    @State private var selectedExercises: Set<String> = []
    @State private var generatedPlan: [String] = []
    @State private var showSummary = false

    let allExercises = [
        "Push Ups", "Mountain Climbers", "Squats", "Side Plank", "Squat", "Wall Sit", "Lunges", "Sit Ups", "Crunches", "Spider Crawl", "Plank"
    ]

    let timeBasedExercises: Set<String> = ["Plank", "Wall Sit", "Side Plank"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create Your Workout Plan")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .padding(.top)
            
            Menu {
                Button("Beginner") { selectedLevel = "Beginner" }
                Button("Intermediate") { selectedLevel = "Intermediate" }
                Button("Advanced") { selectedLevel = "Advanced" }
            } label: {
                HStack {
                    Text("Difficulty: \(selectedLevel)")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
            }

            HStack {
                Text("Select Exercises")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                NavigationLink(destination: ExerciseLibraryView()) {
                    Text("Exercise Library")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(allExercises, id: \.self) { exercise in
                        HStack {
                            Text(exercise)
                                .foregroundColor(.black)

                            Spacer()

                            Image(systemName: selectedExercises.contains(exercise) ? "checkmark.square.fill" : "square")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    toggleExercise(exercise)
                                }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                }
            }
            .frame(maxHeight: 350)

            Button(action: {
                generateWorkoutPlan()
                showSummary = true
            }) {
                Text("Create Plan")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }

            Spacer()

            NavigationLink(
                destination: WorkoutSummaryView(plan: generatedPlan, level: selectedLevel),
                isActive: $showSummary
            ) {
                EmptyView()
            }
        }
        .padding()
        .background(Color(.systemGray6).ignoresSafeArea())
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
