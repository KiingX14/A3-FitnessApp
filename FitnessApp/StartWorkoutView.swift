//
//  StartWorkoutView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct StartWorkoutView: View {
    let plan: [String]

    var body: some View {
        VStack(spacing: 20) {
            Text("Workout In Progress")
                .font(.title)
                .fontWeight(.bold)

            List(plan, id: \.self) { item in
                Text(item)
            }

            Spacer()
        }
        .padding()
    }
}
