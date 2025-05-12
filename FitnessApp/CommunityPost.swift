//
//  CommunityPost.swift
//  FitnessApp
//
//  Created by Le Hoang Thanh Lam on 13/5/2025.
//

import Foundation

struct CommunityPost: Identifiable {
    let id = UUID()
    let username: String
    let message: String
    let timestamp: String
}
