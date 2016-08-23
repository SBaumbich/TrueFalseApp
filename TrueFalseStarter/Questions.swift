//
//  Questions.swift
//  TrueFalseStarter
//
//  Created by Scott Baumbich on 8/21/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct Questions {
   
    var indexOfSelectedQuestion: [Int] = []
    
    let questions: [[String:String]] = [
        ["Question": "This was the only US President to serve more than two consecutive terms.", "Option1": "George Washington", "Option2": "Franklin D. Roosevelt", "Option3": "Woodrow Wilson", "Option4": "Andrew Jackson"],
        
        ["Question": "Which of the following countries has the most residents?", "Option1": "Nigeria", "Option2": "Russia", "Option3": "Iran", "Option4": "Vietnam"],
        
        ["Question": "In what year was the United Nations founded?", "Option1": "1918", "Option2": "1919", "Option3": "1945", "Option4": "1954"],
        
        ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?", "Option1": "Paris", "Option2": "Washington D.C.", "Option3": "New York City", "Option4": "Boston"],
        
        ["Question": "Which nation produces the most oil?", "Option1": "Iran", "Option2": "Iraq", "Option3": "Brazil", "Option4": "Canada"],
        
        ["Question": "Which country has most recently won consecutive World Cups in Soccer?", "Option1": "Italy", "Option2": "Brazil", "Option3": "Argetina", "Option4": "Spain"],
        
        ["Question": "Which of the following rivers is longest?", "Option1": "Yangtze", "Option2": "Mississippi", "Option3": "Congo", "Option4": "Mekong"],
        
        ["Question": "Which city is the oldest?", "Option1": "Mexico City", "Option2": "Cape Town", "Option3": "San Juan", "Option4": "Sydney"],
        
        ["Question": "Which country was the first to allow women to vote in national elections?", "Option1": "Poland", "Option2": "United States", "Option3": "Sweden", "Option4": "Senegal"],
        
        ["Question": "Which of these countries won the most medals in the 2012 Summer Games??", "Option1": "France", "Option2": "Germany", "Option3": "Japan", "Option4": "Great Britian"]
    ]
    
    // Get random Index Number
    func randomIndexNum() -> Int {
        return GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
    }
    
    mutating func selectRandomQuestion() -> [String:String] {
        var questionSelected = false
        
        while (questionSelected == false) {
            let randomQ = randomIndexNum()
            
            if (indexOfSelectedQuestion.count >= questions.count){
                break
            }
            else if indexOfSelectedQuestion.contains(randomQ) {
                // Guess another number
                print(randomQ)
            } else {
                let selectedQuestion = questions[randomQ]
                indexOfSelectedQuestion.append(randomQ)
                questionSelected = true
                return selectedQuestion
            }
        }
        return ["nil": "nil"]
    }
}







