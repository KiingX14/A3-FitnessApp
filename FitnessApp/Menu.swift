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

    var body: some View {
        VStack(spacing: 30) {
            // app title
            Text("QuickFit")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)

            // top bar
            HStack(spacing: 12) {
                if !username.isEmpty {
                    Text("👋 Hello, \(username)")
                        .font(.headline)
                        .foregroundColor(.black)
                }

                Spacer()

                // profile menu
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

    // Reusable button
    @ViewBuilder
    private func menuButton(title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue) // you can change any colour you want by replace the Color.colouryouwant
            .cornerRadius(12)
    }
}
