//
//  ViewController.swift
//  RemasteredCalculator
//
//  Created by Reed Carson on 1/30/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let calculator = Calculator()
    var inputStack = StringInputStack()
    
    
    @IBOutlet weak var outputLabel: UILabel!
    

    @IBAction func clearButton(sender: UIButton) {
        


        
    }
    
    @IBAction func calculateButton(sender: UIButton) {

        let dataSource = inputStack.convertStack()
        let output = calculator.performOperation(dataSource)
        outputLabel.text = String(output)
        inputStack.items = []
    }
    
    
    @IBAction func userInput(sender: UIButton) {
    
        guard let input = sender.currentTitle else { return }
        
        inputStack.items.append(input)
        
        print(input)
        print(inputStack.items)
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    
}

