//
//  ViewController.swift
//  RemasteredCalculator
//
//  Created by Reed Carson on 1/30/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit


var numberOne: String = ""
var numberTwo: String = ""
var currentOperation: String = ""
var computedAnswer: String = ""


class ViewController: UIViewController {
    
    var stage = GlobalVariables().stageOfOperations
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    
    @IBAction func clearButton(sender: UIButton) {
        
        clearMemory()
        outputLabel.text = ""
        stage = StageOfOperation.PreOperator

        
    }
    
    @IBAction func calculateButton(sender: UIButton) {
        
        guard let
            a = Double(numberOne),
            b = Double(numberTwo),
            operation = Operation(rawValue: currentOperation)
            else { return }
        
        
        computedAnswer = String(performOperation(a, b: b, operation: operation))
        
        outputLabel.text = "\(computedAnswer)"
        
        stage = StageOfOperation.PostOperator
        
    }
    
    
    @IBAction func operationInput(sender: UIButton) {
        
        guard let input = sender.currentTitle else { return }
        if outputLabel.text == "" { return }
        
        switch stage {
        case .PreOperator:
            outputLabel.text = "\(numberOne) \(input)"
            currentOperation = input
            stage = StageOfOperation.Operator
        case .Operator: return
        case .PostOperator:
            numberOne = computedAnswer
            numberTwo = ""
            currentOperation = input
            outputLabel.text = "\(numberOne) \(input)"
            stage = StageOfOperation.Operator
            
        }
        
    }
    

    @IBAction func variableInput(sender: UIButton) {

        
        guard let input = sender.currentTitle else { return }
        
        switch stage {
        
        case .PreOperator:
            if input == "back" {
                if outputLabel.text != "" {
                    numberOne = (String(outputLabel.text!.characters.dropLast()))
                }
            } else {
                numberOne += input
            }
            
            outputLabel.text = numberOne

            
        case .Operator:
            if input == "back" {
                if numberTwo != "" {
                    numberTwo = (String(numberTwo.characters.dropLast()))
                }
            } else {
                numberTwo += input
            }
            outputLabel.text = "\(numberOne) \(currentOperation) \(numberTwo)"
        
        case .PostOperator:
            
            clearMemory()
            
            stage = StageOfOperation.PreOperator
            if input == "back" {
                outputLabel.text = ""
            } else {
            numberOne = input
            outputLabel.text = "\(numberOne)"
                
            }
        
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stage = StageOfOperation.PreOperator
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

