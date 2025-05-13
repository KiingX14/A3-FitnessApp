//
//  WorkoutTrackingManager.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import Foundation
import SwiftUI

/// Manages all workout tracking functionality including data persistence,
/// current workout state, and workout statistics
/// 
/// This is the central manager class for the workout tracking feature and
/// provides access to workout history, current workout status, and streak
/// calculation.
class WorkoutTrackingManager: ObservableObject {
    /// Shared singleton instance for app-wide access
    static let shared = WorkoutTrackingManager()
    
    /// Complete history of all workout sessions
    @Published var workoutHistory: [WorkoutSession] = []
    
    /// Currently active workout session (if any)
    @Published var currentSession: WorkoutSession?
    
    /// Flag indicating if a workout is currently in progress
    @Published var isWorkoutActive: Bool = false
    
    /// Timer for tracking workout duration
    private var timer: Timer?
    
    /// Start time of the current workout
    private var startTime: Date?
    
    /// Initializes the manager and loads saved workout history
    init() {
        loadWorkoutHistory()
    }
    
    /// Starts a new workout session
    /// - Parameter workoutName: Name of the workout
    /// - Returns: The created workout session
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
    
    /// Updates the duration of the current workout (called by timer)
    private func updateDuration() {
        guard let startTime = startTime, var session = currentSession else { return }
        let elapsed = Int(Date().timeIntervalSince(startTime))
        session.durationInSeconds = elapsed
        currentSession = session
    }
    
    /// Completes the current workout session
    /// - Parameters:
    ///   - exercises: List of exercises with completion status
    ///   - userRating: Optional user rating (1-5)
    ///   - notes: Optional user notes
    ///   - mood: Optional user mood
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
    
    /// Calculates the current workout streak (consecutive days with workouts)
    /// - Returns: Number of consecutive days with workouts
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
    
    /// Saves workout history to persistent storage
    private func saveWorkoutHistory() {
        if let encoded = try? JSONEncoder().encode(workoutHistory) {
            UserDefaults.standard.set(encoded, forKey: "workoutHistory")
        }
    }
    
    /// Loads workout history from persistent storage
    private func loadWorkoutHistory() {
        if let data = UserDefaults.standard.data(forKey: "workoutHistory"),
           let history = try? JSONDecoder().decode([WorkoutSession].self, from: data) {
            workoutHistory = history
        }
    }
    
    /// Generates sample workout data for testing and demonstration
    func generateSampleData() {
        // Clear existing data
        workoutHistory = []
        
        // Add some sample workouts for demonstration purposes
        let sampleNames = ["Morning HIIT", "Full Body Workout", "Quick Cardio", "Upper Body Focus"]
        let today = Date()
        
        for i in 0..<10 {
            // Skip some days to make streak calculation more interesting
            if i == 3 || i == 4 {
                continue
            }
            
            let workoutName = sampleNames[Int.random(in: 0..<sampleNames.count)]
            let date = Calendar.current.date(byAdding: .day, value: -i, to: today)!
            let duration = Int.random(in: 15...45) * 60
            let calories = duration / 60 * Int.random(in: 4...10)
            
            let session = WorkoutSession(
                date: date,
                workoutName: workoutName,
                durationInSeconds: duration,
                caloriesBurned: calories,
                completionPercentage: Double.random(in: 70...100),
                userRating: Int.random(in: 3...5)
            )
            
            workoutHistory.append(session)
        }
        
        saveWorkoutHistory()
    }

    /// Cancels the current workout without saving it
    func cancelWorkout() {
    // Stop timer
        timer?.invalidate()
        timer = nil
    
    // Reset tracking state
        currentSession = nil
        isWorkoutActive = false
        startTime = nil
    }
}