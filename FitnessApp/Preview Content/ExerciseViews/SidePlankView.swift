//
//  SidePlankView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct SidePlankView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Side Plank")
                .font(.title)
                .fontWeight(.bold)

            Image("sideplank")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("Lie on one side and lift your hips off the ground, supporting your body on one forearm and the side of one foot. Keep your back flat and your core engaged. Hold, then switch sides. This exercise focuses on your side abs, core as well as your glutes.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
