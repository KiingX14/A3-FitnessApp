//
//  Untitled.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct ExerciseLibraryView: View {
    var body: some View {
            VStack {
                NavigationLink(destination: MenuView()) {
                    Text("Push Up")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Squat")
                }
                NavigationLink(destination: MountainClimberView()) {
                    Text("Mountain Climber")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Plank")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Side Plank")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Wall Sit")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Lunge")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Sit Up")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Crunch")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Spider Crawl")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Jogging")
                }
            }
        
    }
}
