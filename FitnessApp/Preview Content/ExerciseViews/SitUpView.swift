//
//  SitUpView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct SitUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Sit Up")
                .font(.title)
                .fontWeight(.bold)

            Image("situp")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("Lie on your back with knees bent, then lift your torso up toward your thighs and lower back down. This exercise works on your abs, hip flexors, and obliques.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
