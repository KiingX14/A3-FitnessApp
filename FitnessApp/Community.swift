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
            VStack {
                // top bar
                HStack {
                    Text("Community")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        showNewPost = true
                    }) {
                        Image(systemName: "plus.bubble")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)

                // posts list
                List(viewModel.posts) { post in
                    VStack(alignment: .leading, spacing: 6) {
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
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.white.ignoresSafeArea())
            .sheet(isPresented: $showNewPost) {
                NewPostView(viewModel: viewModel, defaultUsername: username)
            }
        }
    }
}
