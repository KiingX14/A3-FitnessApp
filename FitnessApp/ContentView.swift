//
//  ContentView.swift
//  FitnessApp
//
//  Created by Le Hoang Thanh Lam on 4/5/2025.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("selectedAnimalImage") private var selectedAnimalImage: String = ""
    @State private var showAnimalPicker = false
    @State private var animateCard = false

    let animalImages = ["bear", "cat", "chicken", "duck", "meerkat", "owl", "panda", "unicorn1", "unicorn2", "wolf"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 30) {
                    // Welcome Text
                    VStack(spacing: 5) {
                        Text("Welcome to QuickFit")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("Enter your username to get started")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .opacity(animateCard ? 1 : 0)
                    .offset(y: animateCard ? 0 : 20)
                    .animation(.easeOut(duration: 0.6), value: animateCard)

                    // Profile Picture + Reset Button
                    VStack(spacing: 8) {
                        Button {
                            showAnimalPicker = true
                        } label: {
                            if !selectedAnimalImage.isEmpty {
                                Image(selectedAnimalImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else {
                                ZStack {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 100, height: 100)
                                    Image(systemName: "photo")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                }
                            }
                        }

                        if !selectedAnimalImage.isEmpty {
                            Button(action: {
                                selectedAnimalImage = ""
                            }) {
                                Text("Remove Picture")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .opacity(animateCard ? 1 : 0)
                    .scaleEffect(animateCard ? 1 : 0.9)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: animateCard)

                    // Username Field
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .opacity(animateCard ? 1 : 0)
                        .animation(.easeOut.delay(0.1), value: animateCard)

                    // Navigation Button
                    NavigationLink(destination: MenuView()) {
                        Text("Enter")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 300)
                            .background(username.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray : Color.blue)
                            .cornerRadius(12)
                    }
                    .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty)
                    .opacity(animateCard ? 1 : 0)
                    .animation(.easeOut.delay(0.2), value: animateCard)

                    Spacer()
                }
                .padding()
                .onAppear {
                    requestNotificationPermission()
                    animateCard = true
                }
            }
        }
        .sheet(isPresented: $showAnimalPicker) {
            AnimalPickerView(selectedImage: $selectedAnimalImage, animalImages: animalImages)
        }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print(granted ? "Notification permission granted" : "Notification denied")
        }
    }
}

struct AnimalPickerView: View {
    @Binding var selectedImage: String
    let animalImages: [String]
    @Environment(\.dismiss) var dismiss

    let columns = [GridItem(.adaptive(minimum: 80))]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(animalImages, id: \.self) { animal in
                        Image(animal)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(selectedImage == animal ? Color.blue : Color.clear, lineWidth: 4)
                            )
                            .onTapGesture {
                                selectedImage = animal
                                dismiss()
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose Your Avatar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
