//
//  Community.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct CommunityView: View {
    @StateObject private var viewModel = CommunityViewModel()
    @State private var showNewPost = false
    @AppStorage("username") private var username: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // top bar
                HStack {
                    Text("Community")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()

                    ZStack(alignment: .topTrailing) {
                        Button(action: {
                            showNewPost = true
                        }) {
                            Image(systemName: "plus.bubble")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }

                        // Notification dot
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 8, y: -6)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal)

                // posts list
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.posts) { post in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(post.username)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text(post.timestamp)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Text(post.message)
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .sheet(isPresented: $showNewPost) {
                NewPostView(viewModel: viewModel, defaultUsername: username)
            }
        }
    }
}
