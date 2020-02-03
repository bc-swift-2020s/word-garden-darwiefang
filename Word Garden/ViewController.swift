 //
//  ViewController.swift
//  Word Garden
//
//  Created by darwie fang on 31/1/20.
//  Copyright © 2020 darwie fang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "CODE"
    var lettersGuessed = " "
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        print("In viewDidLoad, is guessedLetterField the first responder?", guessedLetterField.isFirstResponder)
    }
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += "  _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    func guessALetter() {
        formatUserGuessLabel()
         guessCount += 1
        // decrements the wrongGuessesRemaining and shows the next flower image
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(guessedLetterField.text!) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage.init(named: "flower\(wrongGuessesRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        
        //stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So Sorry, you're all out of guesses. Try Aagain?"
        } else if !revealedWord.contains("_") {
            // won a game
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            // update guess count
            let guess = (guessCount == 1 ? "guess" : "guesses")
//            var guess = "guesses"
//            if guessCount == 1 {
//                guess = "guess" }
        guessCountLabel.text = "You've made \(guessCount) guesses"
        }

        
        
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        print("Hey! The guessedLetterFieldChanged!!!")
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            guessLetterButton.isEnabled = false
            
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        print("In doneKeyPressed, is guessedLetterField the first responder before UpdateUIAfterGuess", guessedLetterField.isFirstResponder)
        guessALetter()
       updateUIAfterGuess()
        print("In doneKeyPressed, is guessedLetterField the first responder after UpdateUIAfterGuess", guessedLetterField.isFirstResponder)
        
    }
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
         print("In guessLetterButtonPressed, is guessedLetterField the first responder after UpdateUIAfterGuess", guessedLetterField.isFirstResponder)
        guessALetter()
        updateUIAfterGuess()
         print("In guessLetterButtonPressed, is guessedLetterField the first responder after UpdateUIAfterGuess", guessedLetterField.isFirstResponder)
       
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
             guessCountLabel.text = "You've made 0 guesses"
        guessCount = 0
 }

 }
