//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Modified by Scott Baumbich on 8/21/16
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
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
    @IBOutlet var option5: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var option6: UIButton!
    let buttonColor = UIColor(red: 12/255, green: 121/255, blue: 150/255, alpha: 1)
    var timer = NSTimer()
    var count = 15
    var gameQuestions = Questions()
    var game = Game()
    var showMenueScreen = true
    
/////////////////////////////
// MARK: Instance methods ///
/////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        game.playGameSound("GameSound", fileType: "wav")
        displayQuestion()
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
        showMenueScreen = true
        option5.hidden = false
        option6.hidden = false
        nextRound()
        game.playGameSound("GameSound", fileType: "wav")
    }
    
    
    @IBAction func menuAction(sender: UIButton) {
        
        if sender.titleLabel?.text == "Norman" {
            showMenueScreen = false
            option5.hidden = true
            option6.hidden = true
            hideButtons(false)
            displayQuestion()
            
        } else {
            count = 15
            timer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countUp), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
            timerLabel.hidden = false
            showMenueScreen = false
            option5.hidden = true
            option6.hidden = true
            hideButtons(false)
            displayQuestion()
            
        }
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        
        // Lock buttons
        enableButton(false)
        
        // Increment the questions asked counter
        game.questionsAsked += 1
        
        
        let selectedQuestionDict = gameQuestions.currentQuestion
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if sender.titleLabel?.text == correctAnswer! {
            game.correctQuestions += 1
            questionField.text = "Correct!"
            game.playGameSound("SuccessSound", fileType: "mp3")
            loadNextRoundWithDelay(seconds: 1)

        } else {
            questionField.text = "Sorry, wrong answer!"
            game.playGameSound("ErrorSound", fileType: "wav")
            for view in self.view.subviews as [UIView] {
                if let stackView = view as? UIStackView {
                    for button in stackView.subviews as! [UIButton] {
                        if button.titleLabel?.text == correctAnswer {
                            dispatch_async(dispatch_get_main_queue()) {
                                button.backgroundColor = UIColor(red: 18/255, green: 173/255, blue: 42/255, alpha: 1)
                            }
                        }
                    }
                }
            }
            loadNextRoundWithDelay(seconds: 1)
        }
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
        
        if game.questionsAsked >= game.questionsPerRound {
            // Game is over
            timerLabel.hidden = true
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    
    
    
    
    
    
    
    
    func startTimer() {
        count = 15
    }

    func countUp() {
        
        count -= 1
        if(count >= 0) {
            timerLabel.text = String(count)
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                self.count = 15
                // Increment the questions asked counter
                self.game.questionsAsked += 1
                self.questionField.text = "YOU RAN OUT OF TIME!"
                self.game.playGameSound("ErrorSound", fileType: "wav")
                self.loadNextRoundWithDelay(seconds: 1)
            }
        }
    }
    
    func displayScore() {
        
        // Hide the answer buttons
        hideButtons(true)
        
        // Display play again button
        playAgainButton.hidden = false
        timer.invalidate()
        questionField.text = "Way to go!\nYou got \(game.correctQuestions) out of \(game.questionsPerRound) correct!"
        
        
    }
    
    
    func displayQuestion() {
        
        if showMenueScreen == true {
            playAgainButton.hidden = true
            timerLabel.hidden = true
            hideButtons(true)
            questionField.text = "Select Game Mode"
            
            
        } else {
            let questionDictionary = gameQuestions.selectRandomQuestion()
            dispatch_async(dispatch_get_main_queue()) {
                self.timerLabel.text = String(self.count)
                self.questionField.text = questionDictionary["Question"]
                self.option1.setTitle("\(questionDictionary["Option1"]!)", forState: .Normal)
                self.option2.setTitle("\(questionDictionary["Option2"]!)", forState: .Normal)
                self.option3.setTitle("\(questionDictionary["Option3"]!)", forState: .Normal)
                self.option4.setTitle("\(questionDictionary["Option4"]!)", forState: .Normal)
                self.playAgainButton.hidden = true
                self.enableButton(true)
            }
        }
    }
    
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.count = 15
            self.nextRound()
        }
    }
}








