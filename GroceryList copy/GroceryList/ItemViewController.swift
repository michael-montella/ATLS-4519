//
//  ItemViewController.swift
//  GroceryList
//
//  Created by Michael Montella on 3/10/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController {
    var items = [String]()
    var selectedStore = 0
    var storeListDetail = Stores()
    
    @IBAction func unwindSegue (segue:UIStoryboardSegue){
        if segue.identifier == "Done" {
            let source = segue.sourceViewController as! ViewController
            
            if (source.addedItem.isEmpty) == false {
                items.append(source.addedItem)
                tableView.reloadData()
                let chosenStore = storeListDetail.stores[selectedStore]
                storeListDetail.storeData[chosenStore]?.append(source.addedItem)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        storeListDetail.stores = Array(storeListDetail.storeData.keys)
        let chosenStore = storeListDetail.stores[selectedStore]
        items = storeListDetail.storeData[chosenStore]! as [String]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel!.text = items[indexPath.row]

        return cell
    }

// MARK: Delete Item
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            items.removeAtIndex(indexPath.row)
            let chosenStore = storeListDetail.stores[selectedStore]

            storeListDetail.storeData[chosenStore]?.removeAtIndex(indexPath.row)

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {

        }
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fromRow = fromIndexPath.row
        let toRow = toIndexPath.row
        let moveItem = items[fromRow]

        items.removeAtIndex(fromRow)
        items.insert(moveItem, atIndex: toRow)

        let chosenStore = storeListDetail.stores[selectedStore]
        storeListDetail.storeData[chosenStore]?.removeAtIndex(fromRow)
        storeListDetail.storeData[chosenStore]?.insert(moveItem, atIndex: toRow)
    }
    

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
    }

}
