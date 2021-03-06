//
//  ViewController.swift
//  CalculatoriOS9
//
//  Created by Farshad Faradji on 07/05/16.
//  Copyright © 2016 FaFa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    var calculatorCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calculatorCount += 1
        print("Loaded up a new Calculator (count = \(calculatorCount))")
        brain.addUnaryOperation("redSqrt"){ [weak weakSelf = self ] in
            weakSelf?.label.textColor = UIColor.redColor()
            return (sqrt($0))
        }
    }
    
    deinit{
        calculatorCount -= 1
        print("Calculator left the heap (count \(calculatorCount))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var label: UILabel!
    var userInTheMiddleOfAtyping = false
    
    var displayValue : Double {
        get {
            return Double(label.text!)!
        }
        set {
            label.text = String(newValue)
        }
    }
        var brain = CalCulatorBrain()
    
    @IBAction func touchDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userInTheMiddleOfAtyping  {
            label.text = label.text! + digit
        } else {
            label.text = digit
        }
        userInTheMiddleOfAtyping = true
    }
    
    @IBAction func performOperation(sender: UIButton) {
        if userInTheMiddleOfAtyping {
            brain.setOperand(displayValue)
            userInTheMiddleOfAtyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    var savedProgram : CalCulatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
}

