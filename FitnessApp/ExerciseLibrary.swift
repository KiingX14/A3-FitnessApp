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
                NavigationLink(destination: PushUpView()) {
                    Text("Push Up")
                }
                NavigationLink(destination: SquatView()) {
                    Text("Squat")
                }
                NavigationLink(destination: MountainClimberView()) {
                    Text("Mountain Climber")
                }
                NavigationLink(destination: PlankView()) {
                    Text("Plank")
                }
                NavigationLink(destination: SidePlankView()) {
                    Text("Side Plank")
                }
                NavigationLink(destination: WallSitView()) {
                    Text("Wall Sit")
                }
                NavigationLink(destination: LungeView()) {
                    Text("Lunge")
                }
                NavigationLink(destination: SitUpView()) {
                    Text("Sit Up")
                }
                NavigationLink(destination: CrunchView()) {
                    Text("Crunch")
                }
                NavigationLink(destination: SpiderCrawlView()) {
                    Text("Spider Crawl")
                }
                NavigationLink(destination: JoggingView()) {
                    Text("Jogging")
                }
            }
        
    }
}
