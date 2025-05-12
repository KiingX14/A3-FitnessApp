//
//  WorkoutTracking.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

/// Main workout tracking view - the primary entry point for the workout tracking feature
struct WorkoutTrackingView: View {
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    @State private var showingWorkoutForm = false
    @State private var selectedSession: WorkoutSession?
    
    var body: some View {
        NavigationView {
            VStack {
                // Current streak display
                if trackingManager.calculateStreak() > 0 {
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                        Text("Current streak: \(trackingManager.calculateStreak()) days")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                
                // Workout history
                if trackingManager.workoutHistory.isEmpty {
                    ContentUnavailableView(
                        "No Workout History",
                        systemImage: "figure.run",
                        description: Text("Start your fitness journey by tracking your first workout!")
                    )
                } else {
                    List {
                        ForEach(trackingManager.workoutHistory.sorted(by: { $0.date > $1.date })) { session in
                            WorkoutHistoryRow(session: session)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedSession = session
                                }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                
                // Active workout banner
                if trackingManager.isWorkoutActive, let session = trackingManager.currentSession {
                    ActiveWorkoutBanner(session: session)
                        .padding()
                }
            }
            .navigationTitle("Workout Tracking")
            .toolbar {
                Button(action: { showingWorkoutForm = true }) {
                    Label("New Workout", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingWorkoutForm) {
                NewWorkoutView()
            }
            .sheet(item: $selectedSession) { session in
                WorkoutDetailView(session: session)
            }
        }
    }
}

#Preview {
    WorkoutTrackingView()
}