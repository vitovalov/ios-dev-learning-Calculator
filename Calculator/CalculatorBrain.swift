//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Vito on 17/05/2017.
//  Copyright © 2017 Vito. All rights reserved.
//

import Foundation


func changeSign(operand: Double) -> Double {
    return -operand
}

struct CalculatorBrain {
    
    private enum Operation {
        case constant(Double) // associated value
        case unaryOperation((Double) -> Double)
    }
    
    private var accumulator: Double?
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt), // sqrt,
        "cos": Operation.unaryOperation(cos), // cos
        "~": Operation.unaryOperation(changeSign)
    ]
    
    mutating func performOperation(_ symbol:String) {
        
        if let operation = operations[symbol] {
            switch operation   {
            case .constant(let value):
                accumulator = value
                break
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            }
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    /* read only property */
    var result: Double? {
        get {
            return accumulator
        }
        
        //        set {
        //
        //        }
    }
}
