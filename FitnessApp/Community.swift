//
//  Community.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct CommunityView: View {
    @StateObject private var viewModel = CommunityViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(post.username)
                            .font(.headline)
                        Spacer()
                        Text(post.timestamp)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Text(post.message)
                        .font(.body)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Community")
        }
    }
}

