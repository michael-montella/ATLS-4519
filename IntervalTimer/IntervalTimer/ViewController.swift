//
//  ViewController.swift
//  IntervalTimer
//
//  Created by Michael Montella on 3/2/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func backSeque(segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button1.layer.cornerRadius = 3
        button2.layer.cornerRadius = 3
        button3.layer.cornerRadius = 3
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

