//
//  WorkoutSummaryView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct WorkoutSummaryView: View {
    let plan: [String]
    let level: String

    @State private var navigateToWorkout = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Workout Plan: \(level)")
                .font(.title2)
                .fontWeight(.bold)

            List(plan, id: \.self) { item in
                Text("• \(item)")
            }

            // Navigation to workout session
            NavigationLink(destination: StartWorkoutView(plan: plan), isActive: $navigateToWorkout) {
                EmptyView()
            }

            // Action buttons
            HStack(spacing: 20) {
                Button("Start Workout") {
                    navigateToWorkout = true
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Save Plan") {
                    saveWorkoutPlan()
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
    }

    func saveWorkoutPlan() {
        print("Saved plan for \(level): \(plan)")
        // Extend this with UserDefaults or storage later
    }
}
