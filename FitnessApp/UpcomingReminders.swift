//
//  UpcomingReminders.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 12/5/2025.
//

import SwiftUI

struct UpcomingReminderView: View {
    var body: some View {
        List(reminders) { Reminder in
            VStack {
                Text(Reminder.name)
                Divider()
                Text(Reminder.text)
                Text(Reminder.dueTime.formatted(date: .abbreviated, time: .shortened))
                
            }
        }
        .listStyle(.insetGrouped)
    }
}
