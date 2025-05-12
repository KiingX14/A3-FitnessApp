//
//  PushUpView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 12/5/2025.
//

import SwiftUI

struct MountainClimberView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("mountainclimber")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text("Mountain Climber").font(.headline).foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
            Text("Get your heart rate up and get your blood flowing").font(.headline).foregroundColor(.white)
        

            }
            
            
        }
    }
