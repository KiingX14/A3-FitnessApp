import SwiftUI

struct WorkoutDetailView: View {
    let session: WorkoutSession
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header card
                VStack(alignment: .leading) {
                    Text(session.workoutName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(session.date.formatted(date: .long, time: .shortened))
                        .foregroundColor(.secondary)
                    
                    // Stats row
                    HStack(spacing: 20) {
                        StatCard(value: "\(session.durationInSeconds / 60)", unit: "min", icon: "clock.fill")
                        StatCard(value: "\(session.caloriesBurned)", unit: "cal", icon: "flame.fill")
                        StatCard(value: "\(Int(session.completionPercentage))", unit: "%", icon: "checkmark.circle.fill")
                    }
                    .padding(.top, 8)
                    
                    // Mood indicator
                    if let mood = session.mood {
                        HStack {
                            Text("How you felt:")
                                .fontWeight(.medium)
                            
                            Text(mood.rawValue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(moodColor(mood).opacity(0.2))
                                .cornerRadius(12)
                        }
                        .padding(.top, 8)
                    }
                    
                    // Rating
                    if let rating = session.userRating {
                        HStack {
                            Text("Your rating:")
                                .fontWeight(.medium)
                            
                            HStack {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        .padding(.top, 4)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                // Notes section
                if let notes = session.notes, !notes.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Notes")
                            .font(.headline)
                        
                        Text(notes)
                            .padding(.top, 4)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Workout Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func moodColor(_ mood: MoodType) -> Color {
        switch mood {
        case .energized: return .green
        case .good: return .blue
        case .neutral: return .yellow
        case .tired: return .orange
        case .exhausted: return .red
        }
    }
}