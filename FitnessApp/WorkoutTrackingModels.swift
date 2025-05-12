//
//  WorkoutTrackingModels.swift
//  FitnessApp
//
//  Created by William Tan on 12/5/2025.
//

import Foundation

/// Represents a completed or in-progress workout session
/// This is the primary data model for the workout tracking feature
struct WorkoutSession: Identifiable, Codable {
    /// Unique identifier for the workout session
    let id: UUID
    
    /// Date and time when the workout was started
    let date: Date
    
    /// Name/title of the workout
    let workoutName: String
    
    /// Total duration of the workout in seconds
    var durationInSeconds: Int
    
    /// Estimated calories burned during the workout
    var caloriesBurned: Int
    
    /// Percentage of exercises completed (0-100)
    var completionPercentage: Double
    
    /// User's rating of the workout (1-5, optional)
    var userRating: Int?
    
    /// Optional user notes about the workout
    var notes: String?
    
    /// How the user felt after the workout (optional)
    var mood: MoodType?
    
    /// Creates a new workout session with optional default values
    /// - Parameters:
    ///   - id: Unique identifier (defaults to new UUID)
    ///   - date: Start date (defaults to current date/time)
    ///   - workoutName: Name of the workout
    ///   - durationInSeconds: Duration in seconds (defaults to 0)
    ///   - caloriesBurned: Calories burned (defaults to 0)
    ///   - completionPercentage: Percentage completed (defaults to 0)
    ///   - userRating: Optional user rating (1-5)
    ///   - notes: Optional user notes
    ///   - mood: Optional user mood
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

/// Represents how the user felt after completing a workout
enum MoodType: String, Codable, CaseIterable {
    /// Feeling full of energy
    case energized = "Energized"
    
    /// Feeling positive and satisfied
    case good = "Good"
    
    /// Feeling neither positive nor negative
    case neutral = "Neutral" 
    
    /// Feeling fatigued but accomplished
    case tired = "Tired"
    
    /// Feeling completely depleted of energy
    case exhausted = "Exhausted"
}

/// Tracks whether an exercise was completed during a workout
struct ExerciseCompletion: Identifiable, Codable {
    /// Unique identifier
    let id: UUID
    
    /// Reference to the associated workout session
    let sessionId: UUID
    
    /// Name of the exercise
    let exerciseName: String
    
    /// Whether the exercise was completed
    var completed: Bool
    
    /// How difficult the user found the exercise (1-3, optional)
    var difficultyRating: Int?
    
    /// Creates a new exercise completion record
    /// - Parameters:
    ///   - id: Unique identifier (defaults to new UUID)
    ///   - sessionId: ID of the associated workout session
    ///   - exerciseName: Name of the exercise
    ///   - completed: Whether exercise was completed (defaults to false)
    ///   - difficultyRating: Optional difficulty rating (1-3)
    init(id: UUID = UUID(), sessionId: UUID, exerciseName: String, completed: Bool = false, difficultyRating: Int? = nil) {
        self.id = id
        self.sessionId = sessionId
        self.exerciseName = exerciseName
        self.completed = completed
        self.difficultyRating = difficultyRating
    }
}