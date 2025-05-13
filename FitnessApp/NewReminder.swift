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
    @State var navigate: Bool = false
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
            NavigationLink(destination: ReminderView(), isActive: $navigate) {}
            Button("Create") {
                let reminder = Reminder(name: rName, text: rText, dueTime: rDueTime)
                reminders.append(reminder)
                setNote(name: rName, text: rText, time: rDueTime)
                navigate = true
                
            }
            .padding()
        }
        
        
    }
    
    
}

func setNote(name: String, text: String, time: Date) {
    let n = UNMutableNotificationContent()
    n.title = name
    n.body = text
    n.sound = UNNotificationSound.default
    let c = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: time)
    let trigger = UNCalendarNotificationTrigger(dateMatching: c, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: n, trigger: trigger)
    UNUserNotificationCenter.current().add(request) {error in}
    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in }
    
}
