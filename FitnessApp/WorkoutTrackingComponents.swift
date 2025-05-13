//
//  WorkoutTrackingComponents.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import SwiftUI

struct StatCard: View {
    let value: String
    let unit: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title3)
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

struct ActiveWorkoutBanner: View {
    let session: WorkoutSession
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    @State private var showingCompletionSheet = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Active Workout")
                        .font(.headline)
                    Text(session.workoutName)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text(formatDuration(session.durationInSeconds))
                    .font(.title2)
                    .monospacedDigit()
                    .foregroundColor(.primary)
            }
            
            Button("Complete Workout") {
                showingCompletionSheet = true
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 8)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
        .sheet(isPresented: $showingCompletionSheet) {
            WorkoutCompletionView()
        }
    }
    

    private func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
