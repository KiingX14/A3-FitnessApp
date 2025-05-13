//
//  PastReminders.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 12/5/2025.
//

import SwiftUI

struct PastReminderView: View {
    
    var body: some View {
        Text("Past Reminders")
            .onAppear{append()}
        List(pastReminders) { Reminder in
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

func append() {
    for reminder in reminders {
        if (reminder.dueTime < Date()) {
            pastReminders.append(reminder)
            reminders.removeAll{ $0.dueTime < Date() }
        }
    }
}
