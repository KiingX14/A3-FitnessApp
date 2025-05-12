import SwiftUI

// MARK: - Main View
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

// MARK: - History Row Component
struct WorkoutHistoryRow: View {
    let session: WorkoutSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(session.workoutName)
                .font(.headline)
            
            HStack {
                Label(session.date.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Label("\(session.durationInSeconds / 60) min", systemImage: "clock")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Show completion percentage
            ProgressView(value: session.completionPercentage / 100)
                .tint(completionColor(for: session.completionPercentage))
                .padding(.top, 4)
        }
        .padding(.vertical, 4)
    }
    
    private func completionColor(for percentage: Double) -> Color {
        switch percentage {
        case 0..<50: return .red
        case 50..<80: return .orange
        default: return .green
        }
    }
}

// MARK: - Active Workout Component
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
                
                // Elapsed time
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