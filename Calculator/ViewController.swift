//
//  ViewController.swift
//  Calculator
//
//  Created by Vito on 15/05/2017.
//  Copyright © 2017 Vito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        brain.addUnaryOperation(named: "✅") {
//            // memory cycle. We're capturing self here. Because this closure that lives in the heap, and points to self. addUnaryOp is gonna cause this closure put in the operations table which is pointed by the VC and now they point at each other
//            self.display.textColor = UIColor.green
//            return sqrt($0)
//        }
//        brain.addUnaryOperation(named: "✅") { [unowned self] in
        brain.addUnaryOperation(named: "✅") { [weak weakSelf = self] in
            weakSelf?.display.textColor = UIColor.green
            return sqrt($0)
        }
    }
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            // print("touched \(digit) digit")
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
    
}

