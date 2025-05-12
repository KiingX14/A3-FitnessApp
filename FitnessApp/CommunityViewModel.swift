//
//  CommunityViewModel.swift
//  FitnessApp
//
//  Created by Le Hoang Thanh Lam on 13/5/2025.
//

import Foundation

class CommunityViewModel: ObservableObject {
    @Published var posts: [CommunityPost] = []

    init() {
        loadPosts()
    }

    func loadPosts() {
        // Softcoded
        posts = [
            CommunityPost(username: "Sarah", message: "Just finished a 10-minute stretch! Feeling refreshed 💪", timestamp: "2h ago"),
            CommunityPost(username: "Mike", message: "No time for gym? No worries—15 mins of home HIIT did the job 🔥", timestamp: "5h ago"),
            CommunityPost(username: "Jin", message: "Started small, now it’s a habit. You got this!", timestamp: "1d ago")
        ]
    }
}
