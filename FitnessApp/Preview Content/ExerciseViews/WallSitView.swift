//
//  WallSitView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct WallSitView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Wall Sit")
                .font(.title)
                .fontWeight(.bold)

            Image("wallsit")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("Slide your back down a wall until thighs are parallel to the floor and hold the position. This works the muscles of your lower body such as your quads, hamstrings, glutes, and calves.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
