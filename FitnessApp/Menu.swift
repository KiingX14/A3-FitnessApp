//
//  Menu.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct MenuView: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("selectedAnimalImage") private var selectedAnimalImage: String = ""

    var body: some View {
        VStack(spacing: 30) {
            // Top bar
            HStack(spacing: 12) {
                if !selectedAnimalImage.isEmpty {
                    Image(selectedAnimalImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }

                if !username.isEmpty {
                    Text(username)
                        .font(.headline)
                        .foregroundColor(.black)
                }

                Spacer()

                Button(action: {
                    // navigate to settings or handle logout
                    print("Settings tapped")
                }) {
                    Image(systemName: "gearshape")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)

            Text("Menu")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.black)

            // menu options
            VStack(spacing: 16) {
                NavigationLink(destination: WorkoutPlanView()) {
                    menuButton(title: "Workout Plans")
                }
                NavigationLink(destination: ExerciseLibraryView()) {
                    menuButton(title: "Exercise Library")
                }
                NavigationLink(destination: WorkoutTrackingView()) {
                    menuButton(title: "Workout Tracking")
                }
                NavigationLink(destination: ReminderView()) {
                    menuButton(title: "Reminders")
                }
                NavigationLink(destination: CommunityView()) {
                    menuButton(title: "Community")
                }
            }
            .frame(maxWidth: 300)
            .padding(.top)

            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }

    // Reusable button
    @ViewBuilder
    private func menuButton(title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue) // you can choose any colour that you want just replace the colour name.
            .cornerRadius(12)
    }
}
