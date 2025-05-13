//
//  PlankView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct PlankView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Plank")
                .font(.title)
                .fontWeight(.bold)

            Image("plank")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("Hold a straight arm position with your body in a straight line from head to heels, similar to the starting position of a push up. Hold that pose. This exercise targets your core muscles, including your abs, obliques, and lower back.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
