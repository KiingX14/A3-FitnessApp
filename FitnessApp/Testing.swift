//
//  Testing.swift
//  FitnessApp
//
//  Created by Le Hoang Thanh Lam on 4/5/2025.
//

import SwiftUI

struct Testing: View {
    var body: some View {
        VStack {
            Text(greet(name: "Lam"))
                .padding()
        }
    }

    func greet(name: String) -> String {
        return "Hello, \(name)!"
    }
}

