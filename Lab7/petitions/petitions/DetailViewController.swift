//
//  DetailViewController.swift
//  petitions
//
//  Created by Michael Montella on 3/16/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!

    var detailItem: String?
    
    func loadWebPage(urlString: String) {
        // The urlString should be a properly formed URL
        
        // Create NSURL object
        let url = NSURL(string: urlString)
        // Create NSURLRequest Object
        let request = NSURLRequest(URL: url!)
        // Load NSURLRequest object in web view
        webView.loadRequest(request)
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let url = detailItem {
            loadWebPage(url)
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        webSpinner.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webSpinner.stopAnimating()
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

