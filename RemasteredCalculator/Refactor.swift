//
//  Refactor.swift
//  RemasteredCalculator
//
//  Created by Reed Carson on 4/15/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import Foundation


protocol DisplayType {
    func updateLabel()
}


// MARK - Calculator

enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Multiply = "*"
    case Divide = "/"
    
    static let validOperations = ["+","-","*","/"]
    static let opsSet = NSCharacterSet(charactersInString: "+-/*")
}

protocol CalculatorType {
    func performOperation(dataSource: CalculatorDataSource) -> Double
}

struct Calculator: CalculatorType {
    func performOperation(dataSource: CalculatorDataSource) -> Double {
        switch dataSource.operation {
        case .Add: return dataSource.a + dataSource.b
        case .Subtract: return dataSource.a - dataSource.b
        case .Multiply: return dataSource.a * dataSource.b
        case .Divide: if dataSource.b == 0 { return 0 } else {
            return dataSource.a / dataSource.b
            }
        }
    }
}


// MARK: Calculator data source

protocol CalculatorDataSource {
    var a: Double { get }
    var b: Double { get }
    var operation: Operation { get }
}

struct DataSource: CalculatorDataSource {
    var a: Double
    var b: Double
    var operation: Operation
}


// MARK: String Input handling

struct StringInputStack {   // handles binary operations, in format "a 'op' b" only
    
    var displayDelegate: DisplayType?
    
    
    var inputString = ""
    var string: [String] { return inputString.componentsSeparatedByCharactersInSet(Operation.opsSet) }
  
    // var a: String { if string.count < 2 { return inputString } else { return string[0] } }
    //var b: String { if string.count < 2 { return "" } else { return string[1] } }
    
    var a: String { return string.count < 2 ? inputString : string[0] }
    var b: String { return string.count < 2 ? "" : string[1] }
    
    var operation: String {
        for i in Operation.validOperations {
            if inputString.containsString(i) {
                return i
            }
        }
        return "invalid operation"
    }
   
    var lastAnswer: Double = 0.0
    var hasOperator: Bool { return Operation.validOperations.contains(operation) }
    
    mutating func clearStack() {
        inputString.removeAll()
    }
    
    mutating func push(item: String) {
        
        if Operation.validOperations.contains(item) {
            if inputString == "" { return }
            for i in Operation.validOperations {
                if inputString.containsString(i) { return }
            }
        }
        
        ////// formatting input ********
        
        
        if item == "." {
            if a.isEmpty {
                inputString += "0"
            }
            if hasOperator && b.isEmpty {
                inputString += "0"
            }
            if hasOperator {
                if b.containsString(item) {
                    return
                }
                
            } else if a.containsString(item) {
                return
            }
        }
        
        if Operation.validOperations.contains(item) {
            if inputString.characters.last == "." {
                inputString += "0"
            }
        }
        
        inputString += item
    }
    
    mutating func pop() {
        inputString = String(inputString.characters.dropLast())
    }
    
    
    func convertStack() -> CalculatorDataSource? {
        
        guard let aDouble = Double(a), bDouble = Double(b), op = Operation(rawValue: operation) else { print("default result") ; return nil }
        
        return DataSource(a: aDouble, b: bDouble, operation: op)
        
    }
}
