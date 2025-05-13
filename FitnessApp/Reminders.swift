//
//  Reminders.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct ReminderView: View {
    var body: some View {
        VStack(spacing: 30) {
            // title
            Text("Reminders")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)

            // reminder optioons
            VStack(spacing: 16) {
                NavigationLink(destination: NewReminderView()) {
                    reminderButton(title: "New Reminder")
                }
                NavigationLink(destination: UpcomingReminderView()) {
                    reminderButton(title: "Upcoming Reminders")
                }
                NavigationLink(destination: PastReminderView()) {
                    reminderButton(title: "Past Reminders")
                }
            }
            .frame(maxWidth: 300)

            Spacer()
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }

    // Reusable button
    @ViewBuilder
    private func reminderButton(title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue) // you can choose any colour that you want just replace the colour name.
            .cornerRadius(12)
    }
}
