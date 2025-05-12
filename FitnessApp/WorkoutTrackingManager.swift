import Foundation
import SwiftUI

// MARK: - Storage/Tracking Manager
class WorkoutTrackingManager: ObservableObject {
    static let shared = WorkoutTrackingManager()
    
    @Published var workoutHistory: [WorkoutSession] = []
    @Published var currentSession: WorkoutSession?
    @Published var isWorkoutActive: Bool = false
    
    private var timer: Timer?
    private var startTime: Date?
    
    init() {
        loadWorkoutHistory()
    }
    
    // Start a new workout session
    func startWorkout(workoutName: String) -> WorkoutSession {
        let session = WorkoutSession(workoutName: workoutName)
        currentSession = session
        isWorkoutActive = true
        startTime = Date()
        
        // Start timer for duration tracking
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateDuration()
        }
        
        return session
    }
    
    // Update workout duration while in progress
    private func updateDuration() {
        guard let startTime = startTime, var session = currentSession else { return }
        let elapsed = Int(Date().timeIntervalSince(startTime))
        session.durationInSeconds = elapsed
        currentSession = session
    }
    
    // Complete a workout session
    func completeWorkout(exercises: [ExerciseCompletion], userRating: Int? = nil, notes: String? = nil, mood: MoodType? = nil) {
        guard var session = currentSession else { return }
        
        // Stop timer
        timer?.invalidate()
        timer = nil
        
        // Update session details
        let completedExercises = exercises.filter { $0.completed }.count
        session.completionPercentage = exercises.isEmpty ? 100 : (Double(completedExercises) / Double(exercises.count) * 100)
        session.userRating = userRating
        session.notes = notes
        session.mood = mood
        
        // Calculate estimated calories (simplified for MVP)
        session.caloriesBurned = session.durationInSeconds / 60 * 5  // ~5 calories per minute
        
        // Add to history and save
        workoutHistory.append(session)
        saveWorkoutHistory()
        
        // Reset tracking state
        currentSession = nil
        isWorkoutActive = false
        startTime = nil
    }
    
    // Calculate current streak
    func calculateStreak() -> Int {
        let calendar = Calendar.current
        
        // Get unique workout days
        let workoutDays = workoutHistory.map { calendar.startOfDay(for: $0.date) }
        let uniqueDays = Set(workoutDays).sorted(by: >)
        
        guard !uniqueDays.isEmpty else { return 0 }
        
        var streak = 1
        var currentDate = calendar.startOfDay(for: uniqueDays[0])
        
        // Check if most recent workout is today or yesterday
        let today = calendar.startOfDay(for: Date())
        let isRecentWorkout = calendar.isDateInToday(currentDate) || 
                              calendar.isDate(currentDate, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: today)!)
        
        if !isRecentWorkout {
            return 0  // Streak broken if no recent workouts
        }
        
        // Count consecutive days
        for i in 1..<uniqueDays.count {
            let previousDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            
            if calendar.isDate(uniqueDays[i], inSameDayAs: previousDate) {
                streak += 1
                currentDate = previousDate
            } else {
                break  // Streak broken
            }
        }
        
        return streak
    }
    
    // Persistence methods
    private func saveWorkoutHistory() {
        if let encoded = try? JSONEncoder().encode(workoutHistory) {
            UserDefaults.standard.set(encoded, forKey: "workoutHistory")
        }
    }
    
    private func loadWorkoutHistory() {
        if let data = UserDefaults.standard.data(forKey: "workoutHistory"),
           let history = try? JSONDecoder().decode([WorkoutSession].self, from: data) {
            workoutHistory = history
        }
    }
}