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

            Text("Get your heart rate up and get your blood flowing")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

