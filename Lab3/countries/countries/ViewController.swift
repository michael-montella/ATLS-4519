//
//  ViewController.swift
//  countries
//
//  Created by Michael Montella on 2/9/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var continentList = Continents()
    let kfilename = "data.plist"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path:String?
        let filePath = docFilePath(kfilename)
        
        if NSFileManager.defaultManager().fileExistsAtPath(filePath!) {
            path = filePath
        } else {
            path = NSBundle.mainBundle().pathForResource("continents", ofType: "plist")
        }
        
        continentList.continentData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        continentList.continents = Array(continentList.continentData.keys)
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: "UIApplicationWillResignActiveNotification", object: app)
    }
    
    func applicationWillResignActive(notification: NSNotification) {
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        data.addEntriesFromDictionary(continentList.continentData)
        data.writeToFile(filePath!, atomically: true)
    }

    //Required methods for UITableViewDataSource
    //Number of rows in the section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continentList.continentData.count
    }
    
    // Displays table view cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = continentList.continents[indexPath.row]
        return cell
    }
    
    //Handles segues to other view controllers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "countrysegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = continentList.continents[indexPath.row]
            detailVC.continentListDetail=continentList
            detailVC.selectedContinent = indexPath.row
        } else if segue.identifier == "continentSegue" {
            let infoVC = segue.destinationViewController as! ContinentInfoViewController
            let editingCell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(editingCell)
            infoVC.name = continentList.continents[indexPath!.row]
            let countries = continentList.continentData[infoVC.name]! as [String]
            infoVC.number = String(countries.count)
        }
    }
    
    func docFilePath(filename: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString   // Document Directory
        return dir.stringByAppendingPathComponent(filename) // Creates the full path to our data file
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

