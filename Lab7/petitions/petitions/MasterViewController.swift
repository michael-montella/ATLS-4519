//
//  MasterViewController.swift
//  petitions
//
//  Created by Michael Montella on 3/16/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [[String: String]]()


    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
    }
    
    func loadjson() {
        let urlPath = "https://api.whitehouse.gov/v1/petitions.json?limit=50"
        guard let url = NSURL(string: urlPath)
            else {
                print("url error")
                return
        }
        
        let session = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {(data, response, error) in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            // Download successful
            print("Download successful")
            dispatch_async(dispatch_get_main_queue()) {self.parsejson(data!)}
        })
        // Must call resume to run session
        session.resume()
    }

    func parsejson(data: NSData) {
        do {
            // Get json data
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            // Get all results
            let allresults = json["results"] as! NSArray
            let results = Array(allresults)
            
            // Add results to objects
            for result in results {
                // Check that data exists
                guard let title = result["title"]! as? String,
                    let sigCount = result["signatureCount"] as? NSNumber,
                    let itemurl = result["url"]!as? String
                    else {
                        continue
                }
                
                // Create new object
                let obj = ["title": title, "signature": sigCount.stringValue, "url": itemurl]
                
                // Add object to array
                self.objects.append(obj)
            }
            
            //handle thrown error
        } catch {
            print("Error with JSON: \(error)")
            return
        }
        //reload the table data after the json data has been downloaded
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let petition = objects[indexPath.row]
                let title = petition["title"]
                let url = petition["url"]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url
                controller.title = title
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object["title"]
        if object["signature"] != nil {
            cell.detailTextLabel!.text = object["signature"]! + " signatures"
        }
        
        return cell
    }

//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }


}

