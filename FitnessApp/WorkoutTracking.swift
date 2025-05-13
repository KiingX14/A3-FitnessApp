//
//  WorkoutTracking.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import SwiftUI

struct WorkoutTrackingView: View {
    @StateObject private var trackingManager = WorkoutTrackingManager.shared
    @State private var showingWorkoutForm = false
    @State private var selectedSession: WorkoutSession?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
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
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                // Workout history
                if trackingManager.workoutHistory.isEmpty {
                    Spacer()
                    ContentUnavailableView(
                        "No Workout History",
                        systemImage: "figure.run",
                        description: Text("Start your fitness journey by tracking your first workout!")
                    )
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(trackingManager.workoutHistory.sorted(by: { $0.date > $1.date })) { session in
                                WorkoutHistoryRow(session: session)
                                    .onTapGesture {
                                        selectedSession = session
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 4)
                    }
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
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}

struct WorkoutHistoryRow: View {
    // The workout session to display
    let session: WorkoutSession

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(session.workoutName)
                .font(.headline)
                .foregroundColor(.black)

            HStack {
                Label(session.date.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()

                Label("\(session.durationInSeconds / 60) min", systemImage: "clock")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            ProgressView(value: session.completionPercentage / 100)
                .tint(completionColor(for: session.completionPercentage))
                .padding(.top, 4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    // Returns a color based on completion percentage
    private func completionColor(for percentage: Double) -> Color {
        switch percentage {
        case 0..<50: return .red
        case 50..<80: return .orange
        default: return .green
        }
    }
}
