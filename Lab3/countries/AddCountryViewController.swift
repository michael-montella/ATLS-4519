//
//  AddCountryViewController.swift
//  countries
//
//  Created by Michael Montella on 2/9/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class AddCountryViewController: UIViewController {

    @IBOutlet weak var countryTextField: UITextField!
    
    var addedCountry = String()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doneSegue" {
            // only add country if the text field isn't empty
            if ((countryTextField.text?.isEmpty) == false) {
                addedCountry = countryTextField.text!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
