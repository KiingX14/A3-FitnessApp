//
//  ExerciseLibrary.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct ExerciseLibraryView: View {
    let exercises: [(title: String, icon: String, destination: AnyView)] = [
        ("Push Up", "figure.strengthtraining.traditional", AnyView(PushUpView())),
        ("Squat", "figure.strengthtraining.functional", AnyView(SquatView())),
        ("Mountain Climber", "figure.run", AnyView(MountainClimberView())),
        ("Plank", "figure.core.training", AnyView(PlankView())),
        ("Side Plank", "figure.yoga", AnyView(SidePlankView())),
        ("Wall Sit", "figure.cooldown", AnyView(WallSitView())),
        ("Lunge", "figure.walk", AnyView(LungeView())),
        ("Sit Up", "figure.flexibility", AnyView(SitUpView())),
        ("Crunch", "figure.mind.and.body", AnyView(CrunchView())),
        ("Spider Crawl", "figure.climbing", AnyView(SpiderCrawlView()))
    ]

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // title
            Text("Library")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.horizontal)

            // grid layout
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(exercises, id: \.title) { exercise in
                    NavigationLink(destination: exercise.destination) {
                        libraryButton(title: exercise.title, icon: exercise.icon)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }

    // Reusable button
    @ViewBuilder
    private func libraryButton(title: String, icon: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)

            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
