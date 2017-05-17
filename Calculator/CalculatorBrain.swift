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
        case binaryOperation((Double, Double) -> (Double))
        case equals
    }
    
    private var accumulator: Double?
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt), // sqrt,
        "cos": Operation.unaryOperation(cos), // cos
//        "~": Operation.unaryOperation(changeSign),
//        "x": Operation.binaryOperation(multiply),
//        "/": Operation.binaryOperation(devide),
//        "+": Operation.binaryOperation(multiply),
//        "-": Operation.binaryOperation(multiply),
        
//        "x": Operation.binaryOperation({ (op1, op2) in op1 * op2} ),
        
        // CLOSURES: 
        "x": Operation.binaryOperation({ $0 * $1 }),
        
        "/": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        
        "~": Operation.unaryOperation({ -$0 }),

        
        "=": Operation.equals
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
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                
            case  .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!) //        pbo?.perform(with: accumulator!) same
            pendingBinaryOperation = nil // no longer im in the middle of pending operation
        }
    }
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
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
