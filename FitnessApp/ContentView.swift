//
//  ContentView.swift
//  FitnessApp
//
//  Created by Le Hoang Thanh Lam on 4/5/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var nameEntered: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                    TextField("Username: ", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    NavigationLink(destination: MenuView()) {
                        Text("Enter")
                    }
                    
                }
            .padding()
            }
            
        }
        
    }


#Preview {
    ContentView()
}
