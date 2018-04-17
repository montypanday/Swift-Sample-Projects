//
//  ViewController.swift
//  Swift Light Lamp
//
//  Created by MONTY PANDAY on 13/3/18.
//  Copyright © 2018 MONTY PANDAY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var touchCounter: UILabel!
    
    var counter : Int = 0
    
    @IBAction func lightOnOff(_ sender: UIButton) {
        counter += 1
        touchCounter.text = "\(counter) clicks"
        if(sender.tag == 0){
            sender.setImage(UIImage(named: "light_on"), for: .normal)
            sender.tag = 1
            
        } else {
            sender.setImage(UIImage(named: "light_off"), for: .normal)
            sender.tag = 0
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

