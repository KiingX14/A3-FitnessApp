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
    @Environment(\.presentationMode) var presentationMode

    @State private var showImagePicker = false
    @State private var showNameEditor = false
    @State private var avatarAnimated = false

    // Notification counts
    @State private var reminderCount = 3
    @State private var communityCount = 5

    var body: some View {
        VStack(spacing: 30) {
            // App title
            Text("QuickFit")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)

            // Top bar
            HStack(spacing: 12) {
                if !username.isEmpty {
                    Text("👋 Hello, \(username)")
                        .font(.headline)
                        .foregroundColor(.black)
                }

                Spacer()

                Menu {
                    Button("Change Picture") {
                        showImagePicker = true
                    }
                    Button("Change Name") {
                        showNameEditor = true
                    }
                    Button("Logout", role: .destructive) {
                        username = ""
                        selectedAnimalImage = ""
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Group {
                        if !selectedAnimalImage.isEmpty {
                            Image(selectedAnimalImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .scaleEffect(avatarAnimated ? 1 : 0.8)
                    .opacity(avatarAnimated ? 1 : 0)
                    .animation(.easeOut(duration: 0.5), value: avatarAnimated)
                }
            }
            .padding(.horizontal)
            .onAppear {
                avatarAnimated = true
            }

            // menu options
            VStack(spacing: 16) {
                NavigationLink(destination: WorkoutPlanView()) {
                    menuCard(title: "Workout Plans", icon: "dumbbell")
                }
                NavigationLink(destination: ExerciseLibraryView()) {
                    menuCard(title: "Exercise Library", icon: "book")
                }
                NavigationLink(destination: WorkoutTrackingView()) {
                    menuCard(title: "Workout Tracking", icon: "clock.arrow.circlepath")
                }
                NavigationLink(destination: ReminderView()) {
                    menuCardWithBadge(title: "Reminders", icon: "bell", count: reminderCount)
                }
                NavigationLink(destination: CommunityView()) {
                    menuCardWithBadge(title: "Community", icon: "person.3.fill", count: communityCount)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .sheet(isPresented: $showImagePicker) {
            AnimalPickerView(selectedImage: $selectedAnimalImage, animalImages: [
                "bear", "cat", "chicken", "duck", "meerkat", "owl", "panda", "unicorn1", "unicorn2", "wolf"
            ])
        }
        .alert("Edit Name", isPresented: $showNameEditor, actions: {
            TextField("New name", text: $username)
            Button("OK", role: .cancel) {}
        })
    }

    // Reusable card-style menu button
    @ViewBuilder
    private func menuCard(title: String, icon: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)

            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    // Menu card with a red circular badge count
    @ViewBuilder
    private func menuCardWithBadge(title: String, icon: String, count: Int) -> some View {
        HStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)

                if count > 0 {
                    Text("\(count)")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Circle().fill(Color.red))
                        .offset(x: 10, y: -10)
                }
            }

            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
