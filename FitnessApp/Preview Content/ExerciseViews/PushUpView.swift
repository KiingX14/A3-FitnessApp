//
//  PushUpView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct PushUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Push Up")
                .font(.title)
                .fontWeight(.bold)

            Image("pushup")
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
