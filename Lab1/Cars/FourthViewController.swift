//
//  FourthViewController.swift
//  Cars
//  Lab 1
//
//  Created by Michael Montella on 1/21/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBAction func goToMusic(sender: AnyObject) {
        // Check to see if there's a app installed to handle this URL scheme
        if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "pandora://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string: "pandora://")!)
        } else {
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "music://")!)) {
                UIApplication.sharedApplication().openURL(NSURL(string: "music://")!)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://www.apple.com/music/")!)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
