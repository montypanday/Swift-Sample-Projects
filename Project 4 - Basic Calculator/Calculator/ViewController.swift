//
//  ViewController.swift
//  Calculator
//
//  Created by MONTY PANDAY on 13/3/18.
//  Copyright © 2018 MONTY PANDAY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var X: UITextField!
    @IBOutlet weak var Y: UITextField!
    @IBOutlet weak var History: UILabel!
    @IBOutlet weak var Result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculate(_ sender: UIButton) {
        var value : Double = 0;
        switch sender.tag{
        case 1:
            value = Double(X.text!)! + Double(Y.text!)!
            Result.text = "Result:" + "\n \(value)"
            History.text = "\(History.text!) \n \(X.text!) + \(Y.text!) = \(value)"
            
        case 2:
            value = Double(X.text!)! - Double(Y.text!)!
            Result.text = "Result:" + "\n \(value)"
            History.text = "\(History.text!) \n \(X.text!) - \(Y.text!) = \(value)"
        case 3:
            value = Double(X.text!)! * Double(Y.text!)!
            Result.text = "Result:" + "\n \(value)"
            History.text = "\(History.text!) \n \(X.text!) * \(Y.text!) = \(value)"
        default:
            value = Double(X.text!)! / Double(Y.text!)!
            Result.text = "Result:" + "\n \(value)"
            History.text = "\(History.text!) \n \(X.text!) / \(Y.text!) = \(value)"        }
    }
    
}

