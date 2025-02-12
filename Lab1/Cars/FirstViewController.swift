//
//  FirstViewController.swift
//  Cars
//
//  Created by Michael Montella on 1/19/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var carPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    let category = ["Hypercar", "Supercar", "Sportscar", "Racecar", "Rallycar", "Drift car"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Methods required to implement the picker
    // Required for the UIPickerViewDataSource protocol
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    // Picker Delegate methods
    // Returns the title for the row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    // Called when a row is selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceLabel.text = "You like \(category[row])s"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

