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

            NavigationLink(destination: StartWorkoutView(plan: plan), isActive: $navigateToWorkout) {
                EmptyView()
            }

            HStack(spacing: 20) {
                Button("Start Workout") {
                    navigateToWorkout = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                NavigationLink(destination: SaveWorkoutView()) {
                    Text("Save Plan")
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
    }
}
