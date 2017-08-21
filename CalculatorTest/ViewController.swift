import UIKit

class ViewController: UIViewController {
     
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false

    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentTitleDisplay = display.text!
            if textCurrentTitleDisplay.range(of: ".") == nil  || digit != "." {
                display.text = textCurrentTitleDisplay + digit
            }
        }
        else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false 
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(sympol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
   
}

