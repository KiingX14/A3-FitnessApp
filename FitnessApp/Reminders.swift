//
//  Reminders.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct ReminderView: View {
    var body: some View {
            VStack {
                NavigationLink(destination: NewReminderView()) {
                    Text("New Reminder")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Upcoming Reminders")
                }
                NavigationLink(destination: MenuView()) {
                    Text("Past Reminders")
                }
            }
        
    }
}
