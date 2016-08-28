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

/////////////////////////////
// MARK: Instance variables /
/////////////////////////////
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet var option1: UIButton!
    @IBOutlet var option2: UIButton!
    @IBOutlet var option3: UIButton!
    @IBOutlet var option4: UIButton!
    let buttonColor = UIColor(red: 12/255, green: 121/255, blue: 150/255, alpha: 1)
    var gameQuestions = Questions()
    var game = Game()
    
/////////////////////////////
// MARK: Instance methods ///
/////////////////////////////
    
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

/////////////////////////////
// MARK: IBActions //////////
/////////////////////////////
    
    @IBAction func playAgain() {
        // Show the answer buttons
        
        game.questionsAsked = 0
        game.correctQuestions = 0
        gameQuestions.indexOfSelectedQuestion = []
        hideButtons(false)
        nextRound()
        game.playGameSound("GameSound", fileType: "wav")
    }
    
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        game.questionsAsked += 1
        
        let selectedQuestionDict = gameQuestions.currentQuestion
        let correctAnswer = selectedQuestionDict["Answer"]
        //enableButton(false)
        
        if sender.titleLabel?.text == correctAnswer! {
            game.correctQuestions += 1
            questionField.text = "Correct!"
            game.playGameSound("SuccessSound", fileType: "mp3")

        } else {
            
            if option1.titleLabel?.text == correctAnswer {
                option1.backgroundColor = UIColor.greenColor()
                option1.titleLabel?.textColor = buttonColor
            }
            if option2.titleLabel?.text == correctAnswer {
                option2.backgroundColor = UIColor.greenColor()
                option2.titleLabel?.textColor = buttonColor
            }
            if option3.titleLabel?.text == correctAnswer {
                option3.backgroundColor = UIColor.greenColor()
                option3.titleLabel?.textColor = buttonColor
            }
            if option4.titleLabel?.text == correctAnswer {
                option4.backgroundColor = UIColor.greenColor()
                option4.titleLabel?.textColor = buttonColor
            }
            questionField.text = "Sorry, wrong answer!"
            game.playGameSound("ErrorSound", fileType: "wav")
        }
        
        loadNextRoundWithDelay(seconds: 1)
    }
    
/////////////////////////////
// MARK: Helper Methods//////
/////////////////////////////
    
    func hideButtons(status: Bool) {
        option1.hidden = status
        option2.hidden = status
        option3.hidden = status
        option4.hidden = status
    }
    
    
    func enableButton(status: Bool) {
        option1.enabled = status
        option2.enabled = status
        option3.enabled = status
        option4.enabled = status
    }
    
    
    func nextRound() {
        
        option1.backgroundColor = buttonColor
        option2.backgroundColor = buttonColor
        option3.backgroundColor = buttonColor
        option4.backgroundColor = buttonColor
        
        if game.questionsAsked == game.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            enableButton(true)
            displayQuestion()
        }
    }
    
    
    func displayScore() {
        
        // Hide the answer buttons
        hideButtons(true)
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(game.correctQuestions) out of \(game.questionsPerRound) correct!"
        
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








