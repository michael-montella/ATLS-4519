//
//  ToDoItem.swift
//  To Do
//
//  Created by Michael Montella on 2/23/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import Foundation

class ToDoItem {
    var name : String
    var reminderDate : NSDate
    var id : String
    
    init (newName: String, newReminderDate: NSDate, newId: String) {
        self.name = newName
        self.reminderDate = newReminderDate
        id = newId
    }
    
    func overDue() -> Bool {
        return (NSDate().compare(self.reminderDate) == NSComparisonResult.OrderedDescending)
    }
}