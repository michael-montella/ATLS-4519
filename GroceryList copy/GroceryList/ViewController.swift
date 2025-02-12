//
//  ViewController.swift
//  GroceryList
//
//  Created by Michael Montella on 3/10/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var itemTextField: UITextField!
    
    var addedItem = String()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Done" {
            if (itemTextField.text?.isEmpty) == false {
                addedItem = itemTextField.text!
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

