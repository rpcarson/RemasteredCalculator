//
//  ViewController.swift
//  RemasteredCalculator
//
//  Created by Reed Carson on 1/30/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var calculator = Calculator()
    var inputStack = StringInputStack()
    
    @IBOutlet weak var outputLabel: UILabel!
    
    func clear() {
        inputStack.clearStack()
        outputLabel.text = "0.0"
        inputStack.lastAnswer = 0.0
    }
    

    @IBAction func clearButton(sender: UIButton) {
      clear()
        
    }
    
    @IBAction func calculateButton(sender: UIButton) {
       
        guard let dataSource = inputStack.convertStack() else { return }
        
        let output = calculator.performOperation(dataSource)
        outputLabel.text = String(output)
        inputStack.lastAnswer = output
        
    }
    
    
    @IBAction func userInput(sender: UIButton) {
        
        guard let input = sender.currentTitle else { return }
        
        if String(inputStack.lastAnswer) == outputLabel.text! {
            clear()
        }
        
        if input == "back" {
            inputStack.pop()
            outputLabel.text = inputStack.inputString
            return
        }
        
        
        inputStack.push(input)
        outputLabel.text = inputStack.inputString
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0.0"
    }

}

