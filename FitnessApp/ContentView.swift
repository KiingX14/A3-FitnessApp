//
//  ContentView.swift
//  FitnessApp
//
//  Created by Le Hoang Thanh Lam on 4/5/2025.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var username: String = ""
    @State private var nameEntered: Bool = false
    
    var body: some View {
        
        NavigationView {
            HStack {
                    TextField("Name ", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onAppear{requestNote()}
                    NavigationLink(destination: MenuView()) {
                        Text("Enter")
                    }
                    
                }
            .padding()
            }
            
        }
    func requestNote() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Granted")
            } else {
                print("Not granted")
            }
        }
    }
        
    }


#Preview {
    ContentView()
}
