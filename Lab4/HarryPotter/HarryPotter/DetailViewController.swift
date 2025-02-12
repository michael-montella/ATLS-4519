//
//  DetailViewController.swift
//  HarryPotter
//
//  Created by Michael Montella on 2/11/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func loadWebPage(urlString: String) {
        let url = NSURL(string: urlString)      //Creats a NSURL object
        let request = NSURLRequest(URL: url!)   // Creat a NSURLRequest object
        webView.loadRequest(request)            // Load the NSURLRequest object in our web view
    }
    
    // UIWebViewDelegate method that is called when a web page begins to load
    func webViewDidStartLoad(webView: UIWebView) {
        webSpinner.startAnimating()
    }
    
    // UIWebViewDelegate method that is called when a web page loads successfully
    func webViewDidFinishLoad(webView: UIWebView) {
        webSpinner.stopAnimating()
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                loadWebPage(detail.description)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

