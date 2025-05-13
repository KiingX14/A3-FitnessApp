//
//  WorkoutTrackingModels.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import Foundation


struct WorkoutSession: Identifiable, Codable {
    // Unique identifier for the workout session
    let id: UUID
    
    let date: Date
    
    let workoutName: String
    
    var durationInSeconds: Int
    
    var caloriesBurned: Int
    
    var completionPercentage: Double
    
    var userRating: Int?
    
    var notes: String?
    
    var mood: MoodType?
    
    // Creates a new workout session with optional default values
    init(id: UUID = UUID(), date: Date = Date(), workoutName: String, durationInSeconds: Int = 0, 
         caloriesBurned: Int = 0, completionPercentage: Double = 0, userRating: Int? = nil, 
         notes: String? = nil, mood: MoodType? = nil) {
        self.id = id
        self.date = date
        self.workoutName = workoutName
        self.durationInSeconds = durationInSeconds
        self.caloriesBurned = caloriesBurned
        self.completionPercentage = completionPercentage
        self.userRating = userRating
        self.notes = notes
        self.mood = mood
    }
}

// Represents how the user felt after completing a workout
enum MoodType: String, Codable, CaseIterable {
    case energized = "Energized"
    
    case good = "Good"
    
    case neutral = "Neutral" 
    
    case tired = "Tired"
    
    case exhausted = "Exhausted"
}

struct ExerciseCompletion: Identifiable, Codable {
    let id: UUID
    
    // Reference to the associated workout session
    let sessionId: UUID
    
    let exerciseName: String
    
    var completed: Bool
    
    var difficultyRating: Int?
    
    init(id: UUID = UUID(), sessionId: UUID, exerciseName: String, completed: Bool = false, difficultyRating: Int? = nil) {
        self.id = id
        self.sessionId = sessionId
        self.exerciseName = exerciseName
        self.completed = completed
        self.difficultyRating = difficultyRating
    }
}
