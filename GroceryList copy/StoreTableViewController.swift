//
//  StoreTableViewController.swift
//  GroceryList
//
//  Created by Michael Montella on 3/10/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {
    
    var storeList = Stores()
    let kfilename = "data.plist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path:String?
        let filePath = docFilePath(kfilename)
        
        if NSFileManager.defaultManager().fileExistsAtPath(filePath!) {
            path = filePath
        } else {
            path = NSBundle.mainBundle().pathForResource("Stores", ofType: "plist")
        }
        storeList.storeData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        storeList.stores = Array(storeList.storeData.keys)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func applicationWillResignActive(notification: NSNotification) {
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        data.addEntriesFromDictionary(storeList.storeData)
        data.writeToFile(filePath!, atomically: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "StoreSegue" {
            let itemVC = segue.destinationViewController as! ItemViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            
            itemVC.title = storeList.stores[indexPath.row]
            itemVC.storeListDetail = storeList
            itemVC.selectedStore = indexPath.row
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return storeList.storeData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)

        cell.textLabel?.text = storeList.stores[indexPath.row]

        return cell
    }
    
    func docFilePath(filename: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString   // Document Directory
        return dir.stringByAppendingPathComponent(filename) // Creates the full path to our data file
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
