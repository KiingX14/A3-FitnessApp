//
//  NewReminder.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 12/5/2025.
//

import SwiftUI

class Reminder {
    var name: String
    var text: String
    var dueTime: Date
    
    init(name: String, text: String, dueTime: Date) {
        self.name = name
        self.text = text
        self.dueTime = dueTime
    }
    
    
    
}

var reminders: [Reminder] = []
