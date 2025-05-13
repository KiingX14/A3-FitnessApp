//
//  MountainClimberView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 12/5/2025.
//

import SwiftUI

struct MountainClimberView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Mountain Climber")
                .font(.title)
                .fontWeight(.bold)

            Image("mountainclimber")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("Start in a plank position and alternate bringing knees toward your chest in a running motion. Keep your core engaged and back flat throughout the exercise. This exercise mostly aims at your core, shoulder, quads and is high intensity.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

