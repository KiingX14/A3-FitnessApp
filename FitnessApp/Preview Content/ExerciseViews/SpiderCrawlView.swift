//
//  SpiderCrawlView.swift
//  FitnessApp
//
//  Created by Raissa Rahardjo on 13/5/2025.
//

import SwiftUI

struct SpiderCrawlView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Spider Crawl")
                .font(.title)
                .fontWeight(.bold)

            Image("spidercrawl")
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("From a high plank, bring one knee toward the outside of the same-side elbow, alternating sides as you crawl forward. This exercise aims to strengthen your core, legs, and arms.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
