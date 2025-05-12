//
//  Exercises.swift
//  FitnessApp
//
//  Created by Nathan Nourse on 9/5/2025.
//

class Exercise {
    var name: String
    var muscles: [String]
    init(name: String, muscles: [String]) {
        self.name = name
        self.muscles = muscles
    }
}

let PushUp = Exercise(name: "Push Up", muscles: [])
let Squat = Exercise(name: "Squat", muscles: [])
let MountainClimber = Exercise(name: "Mountain Climber", muscles: [])
let Plank = Exercise(name: "Plank", muscles: [])
let SidePlank = Exercise(name: "Side Plank", muscles: [])
let WallSit = Exercise(name: "Wall Sit", muscles: [])
let Lunge = Exercise(name: "Lunge", muscles: [])
let SitUp = Exercise(name: "Sit Up", muscles: [])
let Crunch = Exercise(name: "Crunch", muscles: [])
let SpiderCrawl = Exercise(name: "Spider Crawl", muscles: [])
let Jogging = Exercise(name: "Jogging", muscles: [])
