//
//  ViewController.swift
//  Assignment 1
//  Class: IMG214
//  Author: Taylor Fraser
//  Copyright © 2019 Taylor Fraser. All rights reserved.


import UIKit

class ViewController: UIViewController, ChecklistViewControllerDelegate {
    
//    func checklistViewControllerDidCancel(_ controller: ChecklistViewController) {
//         navigationController?.popViewController(animated: true)
//    }
    
    func checklistViewController(_ controller: ChecklistViewController, didFinishEditing items: [ChecklistItem]) {
        var selectedOperators: [String] = []
        for item in items {
            
        if (item.checked == true)
        {
            selectedOperators.append(item.symbol)
        }
    }
        
        Quiz.selectedOperators = selectedOperators
        navigationController?.popViewController(animated: true)
    }
    
    var score = 0
    var round = 1
    var roundOneChecker: Bool = false
    let maxLevel = 10
    
    
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var leftOperandLabel: UILabel!
    @IBOutlet weak var rightOperandLabel: UILabel!
    @IBOutlet weak var theOperatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Quiz.calculateAnswer()
        startNewRound()
        textfield.keyboardType = UIKeyboardType.numberPad
    }
    
    // MARK:- Actions
    @IBAction func addItem() {
      
    }

    @IBAction func showAlert() {
        var message = ""
        
        roundOneChecker = false
        
        if let text = textfield.text
        {
        if let intText = Int(text)
        {
        if intText == Quiz.answer
        {
         roundOneChecker = true
         title = "Equation Invasion"
            
         message = "CORRECT!\nYou are on round \(round) \\ \(Quiz.level + 2)\nPress OK for next question"
            if (round == Quiz.level + 2)
            {
                
                message = "Congrats! You have unlocked level \(Quiz.level + 1)"
            }
        }
        else if (intText != Quiz.answer)
        {
            message = "Incorrect Answer\nPlease try again!"
        }
    }
        else if (Quiz.level == maxLevel) {
            title = "Congratulations!"
            message = "You Won The Game"
        }
        else
        {
            message = "Invalid Input\n Enter a valid number"
        }
    }
        if(round != Quiz.roundRequired)
        {
            
            let alert2 = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let action2 = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.startNewRound()
            })
            alert2.addAction(action2)
        
            present(alert2, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.startNewRound()
            })
            alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func startOver() {
        scoreLabel.text = "0"
        roundLabel.text = "0"
        levelLabel.text = "1"
        round = 1
        score = 0
        Quiz.level = 1
        Quiz.getEquation()
        leftOperandLabel.text = String(Quiz.leftOperand)
        rightOperandLabel.text = String(Quiz.rightOperand)
        theOperatorLabel.text = Quiz.theOperator
        textfield.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "table")
        {
            let controller = segue.destination as! ChecklistViewController
            controller.delegate = self
            //controller.items = Quiz.selectedOperators
        }
    }
    
     func startNewRound() {
        if (roundOneChecker == true)
        {
            Quiz.getEquation()
            roundsInLevels()
            score += Quiz.level * 100
        }
        else if (title == "Invalid Input")
        {
            updateLabels()
        }
        else
        {
            round = 1
        }
        updateLabels()
    }
    
    func updateLabels() {
        levelLabel.text = String(Quiz.level)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        leftOperandLabel.text = String(Quiz.leftOperand)
        rightOperandLabel.text = String(Quiz.rightOperand)
        theOperatorLabel.text = (Quiz.theOperator)
        textfield.text = ""
    }
    
    func roundsInLevels(){
      
        if round == Quiz.roundRequired
        {
            Quiz.level+=1
            round = 1
            Quiz.difficultyLevel*=2
        }
        else
        {
            round+=1
        }
    }
}

class Quiz {
    //selectedOperators.append(ChecklistItem(item.name, item.symbol, checked))
    static var roundRequired = level + 2
    static var level = 1
    static var difficultyLevel = 1
    static var leftOperand = (Int.random(in: 0...10) * difficultyLevel)
    static var rightOperand = (Int.random(in: 0...10) * difficultyLevel)
    static var answer: Int?
    static var selectedOperators: [String] = ["+","-","*","/"]
    static var theOperator = selectedOperators.randomElement()
    
    
    static func getEquation() {
        leftOperand = (Int.random(in: 0...10) * difficultyLevel)
        rightOperand = (Int.random(in: 0...10) * difficultyLevel)
        theOperator = selectedOperators.randomElement()
        
        calculateAnswer()
    }
    
    static func calculateAnswer(){
        
        switch theOperator {
        case "+":
            answer = leftOperand + rightOperand
        case "-":
            answer = leftOperand - rightOperand
        case "/":
            while rightOperand == 0 || rightOperand > leftOperand {
                rightOperand = Int.random(in: 0...10)
            }
            answer = leftOperand / rightOperand
        case "*":
            answer = leftOperand * rightOperand
        default:
            break
        }
    }
}



