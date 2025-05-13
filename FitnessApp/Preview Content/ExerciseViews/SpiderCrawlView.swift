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

            Text("Get your heart rate up and get your blood flowing")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
