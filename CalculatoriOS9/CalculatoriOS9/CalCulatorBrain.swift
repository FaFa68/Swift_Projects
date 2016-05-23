//
//  CalCulatorBrain.swift
//  CalculatoriOS9
//
//  Created by Farshad Faradji on 09/05/16.
//  Copyright © 2016 FaFa. All rights reserved.
//

import Foundation

class CalCulatorBrain {
    
   private var accumulator = 0.0
   private var internalProgram = [AnyObject]()
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double , Double) -> Double)
        case Equal
    }
    func addUnaryOperation(symbol: String ,operation: (Double)-> Double) {
        operations[symbol] = Operation.UnaryOperation(operation)
    }
    var operations : Dictionary<String,Operation> = [
        "Π"   : Operation.Constant(M_PI),
        "e"   : Operation.Constant(M_E),
        "±"   : Operation.UnaryOperation({-$0}),
        "√"   : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×"   : Operation.BinaryOperation({$0 * $1}),
        "÷"   : Operation.BinaryOperation({$0 / $1}),
        "+"   : Operation.BinaryOperation({$0 + $1}),
        "−"   : Operation.BinaryOperation({$0 - $1}),
        "="   : Operation.Equal

    ]
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand)
    
    }
    func performOperation(symbole : String) {
        internalProgram.append(symbole)
        if let operation  = operations[symbole] {
            switch  operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function) :
                accumulator = function(accumulator)
            case .BinaryOperation(let function) :
                executePendingBinaryOperatio()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equal:
                executePendingBinaryOperatio()
            }
        }
    }
    
    private func executePendingBinaryOperatio(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction : (Double , Double ) -> Double
        var firstOperand : Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand)
                    } else if let opertion = op as? String {
                       performOperation(opertion)
                    }
                }
            }           
        }
    }
    func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
}
