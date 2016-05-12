//
//  Refactor.swift
//  RemasteredCalculator
//
//  Created by Reed Carson on 4/15/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import Foundation




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

extension CalculatorType {
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

struct Calculator: CalculatorType {}


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
    
    var inputString = ""
    var lastAnswer: Double = 0.0
    
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
        
        inputString += item
        print(inputString)
    }
    
    mutating func pop() {
        inputString = String(inputString.characters.dropLast())
    }
    
    
    func convertStack() -> CalculatorDataSource? {
        
        let string = inputString.componentsSeparatedByCharactersInSet(Operation.opsSet)
        if string.count < 2 { return nil }
        
        let a = string[0]
        let b = string[1]
        
        var operation: String {
            for i in Operation.validOperations {
                if inputString.containsString(i) {
                    return i
                }
            }
            return "invalid operation"
        }
        
        print(a)
        print(b)
        print(operation)
        
        
        guard let aDouble = Double(a), bDouble = Double(b), op = Operation(rawValue: operation) else { print("default result") ; return nil }
        
        return DataSource(a: aDouble, b: bDouble, operation: op)
        
    }
}
