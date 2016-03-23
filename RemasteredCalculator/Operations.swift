//
//  Operations.swift
//  RemasteredCalculator
//
//  Created by Reed Carson on 1/30/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Multiply = "X"
    case Divide = "/"
}

enum StageOfOperation {
    case PreOperator
    case Operator
    case PostOperator
}

func performOperation(a: Double, b: Double, operation: Operation) -> Double {
    switch operation {
    case .Add: return a + b
    case .Subtract: return a - b
    case .Multiply: return a * b
    case .Divide: return a / b
    }
}
