//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Scott Baumbich on 8/22/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

class Game {

    let questionsPerRound: Int = 10
    var lightningMode: Bool = false
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    
    
    
    func playGameSound(fileName: String, fileType: String) {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
}


