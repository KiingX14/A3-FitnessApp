//
//  LungeView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct LungeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Lunge")
                .font(.title)
                .fontWeight(.bold)

            Image("lunge")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("Step forward with one leg, lowering your hips until both knees are bent at about 90 degrees, then return to standing. Repeat on the other side. This exercise focuses on your quads, glutes, and hamstrings.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
