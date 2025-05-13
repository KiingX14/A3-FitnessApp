import SwiftUI

struct MenuView: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("selectedAnimalImage") private var selectedAnimalImage: String = ""
    @Environment(\.presentationMode) var presentationMode

    @State private var isShowingAvatarSelector = false
    @State private var showNameEditor = false
    @State private var isAvatarVisible = false
    @State private var reminderCount = 3
    @State private var communityCount = 5

    var body: some View {
        VStack(spacing: 24) {
            // Title
            Text("QuickFit")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)

            // Greeting + Avatar Section
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if !username.isEmpty {
                        Text("Hi there,")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(username)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                }

                Spacer()

                // Avatar with menu
                Menu {
                    Button("Change Picture") {
                        isShowingAvatarSelector = true
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
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 50, height: 50)
                            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)

                        Group {
                            if !selectedAnimalImage.isEmpty {
                                Image(selectedAnimalImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(width: 36, height: 36)
                        .scaleEffect(isAvatarVisible ? 1 : 0.85)
                        .opacity(isAvatarVisible ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAvatarVisible)
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                isAvatarVisible = true
            }

            // Menu buttons
            VStack(spacing: 16) {
                NavigationLink(destination: WorkoutPlanView()) {
                    navigationButtonStyle(title: "Workout Plans", icon: "dumbbell")
                }
                NavigationLink(destination: ExerciseLibraryView()) {
                    navigationButtonStyle(title: "Exercise Library", icon: "book")
                }
                NavigationLink(destination: WorkoutTrackingView()) {
                    navigationButtonStyle(title: "Workout Tracking", icon: "clock.arrow.circlepath")
                }
                NavigationLink(destination: ReminderView()) {
                    navigationButtonStyleWithBadge(title: "Reminders", icon: "bell", count: reminderCount)
                }
                NavigationLink(destination: CommunityView()) {
                    navigationButtonStyleWithBadge(title: "Community", icon: "person.3.fill", count: communityCount)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .sheet(isPresented: $isShowingAvatarSelector) {
            AnimalPickerView(selectedImage: $selectedAnimalImage, animalImages: [
                "bear", "cat", "chicken", "duck", "meerkat", "owl", "panda", "unicorn1", "unicorn2", "wolf"
            ])
        }
        .alert("Edit Name", isPresented: $showNameEditor, actions: {
            TextField("New name", text: $username)
            Button("OK", role: .cancel) {}
        })
    }

    // Standard navigation card
    @ViewBuilder
    private func navigationButtonStyle(title: String, icon: String) -> some View {
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
        .cornerRadius(12)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    // Badge version for notifications
    private func navigationButtonStyleWithBadge(title: String, icon: String, count: Int) -> some View {
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
        .cornerRadius(12)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
