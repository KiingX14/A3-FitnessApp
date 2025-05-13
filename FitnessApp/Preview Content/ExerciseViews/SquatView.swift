//
//  SquatView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct SquatView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Squat")
                .font(.title)
                .fontWeight(.bold)

            Image("squat")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("Stand with feet shoulder-width apart, lower your hips back and down as if sitting into a chair, then return to standing. This exercise works your quads, glutes, hamstrings, and calves.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
