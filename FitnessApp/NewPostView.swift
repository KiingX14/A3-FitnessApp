//
//  NewPostView.swift
//  FitnessApp
//
//  Created by Le Hoang Thanh Lam on 13/5/2025.
//

import SwiftUI

struct NewPostView: View {
    @ObservedObject var viewModel: CommunityViewModel
    var defaultUsername: String

    @Environment(\.dismiss) var dismiss
    @State private var message = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("New Post")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Write your message...", text: $message, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(height: 150)

                Button("Post") {
                    let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmedMessage.isEmpty else { return }

                    let post = CommunityPost(username: defaultUsername.isEmpty ? "Anonymous" : defaultUsername,
                                             message: trimmedMessage,
                                             timestamp: "Just now")
                    viewModel.posts.insert(post, at: 0)
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea())
        }
    }
}
