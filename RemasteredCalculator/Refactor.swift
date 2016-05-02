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
    
    var items: [String] = []
    var lastAnswer: Double = 0.0
   
    func getTextRepresentation() -> String {
        if items.isEmpty { return "0.0" }
        var text: String = ""
        for i in items {
            text += i
        }
        return text
    }
    
    
    mutating func clearStack() {
        items = []
    }

    func getItems() -> [String] {
        return items
    }
    
    mutating func push(item: String) {
        
        if Operation.validOperations.contains(item) {
            if items.isEmpty { return }
            for i in Operation.validOperations {
                if items.contains(i) {
                    return
                }
            }
        }
        
        items.append(item)

    }
    
    mutating func pop() {
        if !items.isEmpty {
            items.removeLast()
        }
    }
    
    
    private func getOperator() -> (operation: String, index: Int)? {
        
        var index: Int = -1
        for i in items {
            index += 1
            if Operation.validOperations.contains(i) {
                return (i, index)
            }
        }
        return nil
    }
    
    func convertStack() -> CalculatorDataSource? {
        
        var a: String = ""
        var b: String = ""
        var operation: String = ""
        
        if let (op, index) = getOperator() {
            print(index)
            print(items.count)
            
            operation = op
            
            var indexA = 0
            for i in items[0...index - 1] {
                indexA += 1
                print("index for a: \(indexA)")
                a += i
            }
            
            var indexB = 0
            for i in items[index + 1..<items.count] {
                indexB += 1
                print("index for B: \(indexB)")
                b += i
            }
        }
        
        print(a)
        print(b)
        print(operation)
        
        guard let aDouble = Double(a), bDouble = Double(b), op = Operation(rawValue: operation) else { print("default result") ; return nil }
        
        return DataSource(a: aDouble, b: bDouble, operation: op)
        
    }
}
