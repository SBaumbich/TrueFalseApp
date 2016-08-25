//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Modified by Scott Baumbich on 8/21/16
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet var option1: UIButton!
    @IBOutlet var option2: UIButton!
    @IBOutlet var option3: UIButton!
    @IBOutlet var option4: UIButton!
    var gameQuestions = Questions()
    var game = Game()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        game.playGameSound("GameSound", fileType: "wav")
        displayQuestion()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayQuestion() {
        let questionDictionary = gameQuestions.selectRandomQuestion()
        questionField.text = questionDictionary["Question"]
        option1.setTitle("\(questionDictionary["Option1"]!)", forState: .Normal)
        option2.setTitle("\(questionDictionary["Option2"]!)", forState: .Normal)
        option3.setTitle("\(questionDictionary["Option3"]!)", forState: .Normal)
        option4.setTitle("\(questionDictionary["Option4"]!)", forState: .Normal)
        playAgainButton.hidden = true
    }
    
    func displayScore() {
        
        // Hide the answer buttons
        hideButtons(true)
        
        // Display play again button
        playAgainButton.hidden = false
        
       questionField.text = "Way to go!\nYou got \(game.correctQuestions) out of \(game.questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        game.questionsAsked += 1
        
        let selectedQuestionDict = gameQuestions.currentQuestion
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if sender.titleLabel?.text == correctAnswer! {
            game.correctQuestions += 1
            questionField.text = "Correct!"
            print(sender.titleLabel?.text)
            game.playGameSound("SuccessSound", fileType: "mp3")
        } else {
            questionField.text = "Sorry, wrong answer!"
            print(sender.titleLabel?.text)
            game.playGameSound("ErrorSound", fileType: "wav")
        }
        
        loadNextRoundWithDelay(seconds: 2 )
    }
    
    func nextRound() {
        if game.questionsAsked == game.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func hideButtons(status: Bool) {
        option1.hidden = status
        option2.hidden = status
        option3.hidden = status
        option4.hidden = status
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        
        game.questionsAsked = 0
        game.correctQuestions = 0
        gameQuestions.indexOfSelectedQuestion = []
        hideButtons(false)
        nextRound()
//        game.playGameStartSound()
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
}

