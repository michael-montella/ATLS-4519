//
//  ThirdViewController.swift
//  Cars
//
//  Created by Michael Montella on 1/21/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let manfComponent = 0
    let carComponent = 1
    var carCompanies : [String: [String]]!
    var companies : [String]!
    var cars : [String]!
    
    @IBOutlet weak var manufacturer: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use NSBundle object of the directory for our application to retrieve pathname of cars.plist
        let path = NSBundle.mainBundle().pathForResource("cars", ofType: "plist")
        
        // use NSDictionary to load the plist and cast to a Dictionary
        carCompanies = NSDictionary(contentsOfFile: path!) as! [String: [String]]
        
        // assign all the Dictionary kets in the companies array
        companies = Array(carCompanies.keys)
        
        // assign all the cars for the first company in the cars array
        cars = carCompanies[companies[0]]! as [String]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == manfComponent {
            return companies[row]
        } else {
            return cars[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == manfComponent {
            return companies.count
        } else {
            return cars.count
        }
    }
    
    // called when a row is selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // checks which component is selected
        if component == manfComponent {
            let selectedManf = companies[row] // gets selected company
            cars = carCompanies[selectedManf] // gest the cars for the selected company
            manufacturer.reloadComponent(carComponent)  // reloads the car component
            manufacturer.selectRow(0, inComponent: carComponent, animated: true)  // set the album component back to 0
        }
        let manfRow = pickerView.selectedRowInComponent(manfComponent) // get the selected row for the company
        let carRow = pickerView.selectedRowInComponent(carComponent)   // get the selected row for the car
        choiceLabel.text = "You like the \(companies[manfRow]) \(cars[carRow])"
        
    }
    

}
