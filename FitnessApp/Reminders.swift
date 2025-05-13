//
//  Reminders.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

import SwiftUI

struct ReminderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            // title
            Text("Reminders")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.horizontal)

            // reminder optioons
            VStack(spacing: 16) {
                NavigationLink(destination: NewReminderView()) {
                    reminderCard(title: "New Reminder", icon: "plus.circle")
                }
                NavigationLink(destination: UpcomingReminderView()) {
                    reminderCard(title: "Upcoming Reminders", icon: "calendar.badge.clock")
                }
                NavigationLink(destination: PastReminderView()) {
                    reminderCard(title: "Past Reminders", icon: "clock.arrow.circlepath")
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }

    // Reusable card-style button with icon
    @ViewBuilder
    private func reminderCard(title: String, icon: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)

            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
