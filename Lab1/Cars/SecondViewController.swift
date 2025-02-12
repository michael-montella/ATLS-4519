//
//  SecondViewController.swift
//  Cars
//
//  Created by Michael Montella on 1/19/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var years: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    let decade = ["1960s", "1970s", "1980s", "1990s", "2000s", "2010s"]
    let category = ["Hypercar", "Supercar", "Sportscar", "Racecar", "Rallycar", "Drift car"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return category.count
        } else {
            return decade.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return category[row]
        } else {
            return decade[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categoryRow = pickerView.selectedRowInComponent(0) // Gets the selected row for category
        let decadeRow = pickerView.selectedRowInComponent(1) // Gets the selected row for the decade
        
        choiceLabel.text = "You like \(category[categoryRow])s from the \(decade[decadeRow])"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

