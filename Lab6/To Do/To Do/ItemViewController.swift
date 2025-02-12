//
//  ItemViewController.swift
//  To Do
//
//  Created by Michael Montella on 2/23/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    
    var addedItem : ToDoItem?
    
    func checkNotify() {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings?.types.rawValue == 0 {
            let alert = UIAlertController(title: "Can't schedule notification", message: "Please go to settings to enable notifications", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNotify()
        itemTextField.delegate = self
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            if ((itemTextField.text?.isEmpty) == false) {
                addedItem = ToDoItem(newName: itemTextField.text!, newReminderDate: reminderDatePicker.date, newId: NSUUID().UUIDString)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
