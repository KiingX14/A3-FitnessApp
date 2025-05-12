//
//  Menu.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
            VStack {
                NavigationLink(destination: WorkoutPlanView()) {
                    Text("Workout Plans")
                }
                NavigationLink(destination: ExerciseLibraryView()) {
                    Text("Exercise Library")
                }
                NavigationLink(destination: WorkoutTrackingView()) {
                    Text("Workout Tracking")
                }
                NavigationLink(destination: ReminderView()) {
                    Text("Reminders")
                }
                NavigationLink(destination: CommunityView()) {
                    Text("Community")
                }
            }
        
        
    }
}
