//
//  NewReminder.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 12/5/2025.
//

import SwiftUI



struct NewReminderView: View {
    @State var rName: String = ""
    @State var rText: String = ""
    @State var rDueTime: Date = Date()
    var body: some View {
        
        VStack {
            TextField("Reminder Name: ", text: $rName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Reminder Text: ", text: $rText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            HStack {
                DatePicker("", selection: $rDueTime, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.wheel) // or .compact, .graphical
                    .padding()
            }
            Button("Create") {
                let reminder = Reminder(name: rName, text: rText, dueTime: rDueTime)
                reminders.append(reminder)
            }
            .padding()
        }
        
        
    }
    
    
}
