//
//  ViewController.swift
//  ScrabbleQ
//
//  Created by Michael Montella on 1/26/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords : [String : [String]]!
    var letters : [String]!
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("qwordswithoutu2", ofType: "plist")

        // loads the words of the plist into a dictionary
        allWords = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        
        // Puts all the letters in the array
        letters = Array(allWords.keys)
        
        // Sorts the array
        letters.sortInPlace({$0 < $1})
        
        // Search Results
        let resultsController = SearchResultsController()               // Create an instance of search controller class
        resultsController.allWords = allWords
        resultsController.letters = letters
        // Create a search controller and initialize with our SearchResultsController instance
        searchController = UISearchController(searchResultsController: resultsController)
        
        searchController.searchBar.placeholder = "Enter a search term"  // Place holder text
        searchController.searchBar.sizeToFit()                          // sets appropriate size for search bar
        tableView.tableHeaderView = searchController.searchBar          // install search bar as table header
        searchController.searchResultsUpdater = resultsController       // sets the instance to update search results
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = letters[section]
        let letterSection = allWords[letter]! as [String]
        return letterSection.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let letter = letters[section]
        let wordsSection = allWords[letter]! as [String]
        
        //Configure cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = wordsSection[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let letter = letters[section]
        let wordsSection = allWords[letter]! as [String]
        
        let alert = UIAlertController(title: "Row Selected", message: "You selected \(wordsSection[indexPath.row])", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return letters.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return letters[section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return letters
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

