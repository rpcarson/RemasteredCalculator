//
//  Refactor.swift
//  RemasteredCalculator
//
//  Created by Reed Carson on 4/15/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import Foundation




// MARK - Calculator

enum Operations: String {
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
        case .Divide: return dataSource.a / dataSource.b
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

struct StringInputStack {
    
    var items: [String] = []
    
    func getOperator() -> (operation: String, index: Int)? {
        for i in items {
            var index: Int = 0
            index += 1
            if Operations.validOperations.contains(i) {
                index += 1
                return (i, index)
            }
        }
        return nil
    }
    
    func convertStack() -> CalculatorDataSource {
        
        var a: String = ""
        var b: String = ""
        var operation: String = ""
        
        if let (op, index) = getOperator() {
            operation = op
            
            for i in items[0..<index] {
                a += i
            }
            for i in items[index + 1..<items.count] {
                b += i
            }
        }
        
        print(a)
        print(b)
        print(operation)
        
        guard let aDouble = Double(a), bDouble = Double(b), op = Operation(rawValue: operation) else { return DataSource.init(a: 0, b: 0, operation: .Add) }
        
        return DataSource(a: aDouble, b: bDouble, operation: op)
        
    }
}
