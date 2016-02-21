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

var stage: Int = 1

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!

    @IBAction func clearButton(sender: UIButton) {
    
        stage = 1
        numberTwo = ""
        numberOne = ""
        computedAnswer = ""
        currentOperation = ""
        outputLabel.text = ""

    }
    
    @IBAction func calculateButton(sender: UIButton) {
    
        guard let a = Double(numberOne), b = Double(numberTwo), operation = Operation(rawValue: currentOperation) else { return }
            
        let answer = performOperation(a, b: b, operation: operation)
        
        outputLabel.text = "\(answer)"
        
        print(a)
        print(b)
        print(currentOperation)
        
    }
    
    
    @IBAction func operationInput(sender: UIButton) {
        
        guard let input = sender.currentTitle else { return }
        
        if stage == 2 { return }
        if outputLabel.text == "" { return }
        outputLabel.text = "\(numberOne) \(input)"
        currentOperation = input
        stage = 2
    
    }
    
    
    @IBAction func variableInput(sender: UIButton) {
        
        guard let input = sender.currentTitle else { return }
        
        switch stage {
        case 1:
            numberOne += input
            outputLabel.text = numberOne
        case 2:
            numberTwo += input
            outputLabel.text = "\(numberOne) \(currentOperation) \(numberTwo)"
        default: return
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        stage = 1
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

