//
//  CollectionViewController.swift
//  PictureCollection
//
//  Created by Michael Montella on 2/16/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var carImages = [String]()
    
    var sharing = false
    var selectedImages = [String]()
    
    let sectionInsets = UIEdgeInsets(top: 25.0, left: 1.0, bottom: 25.0, right: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carImages = ["car.jpg", "car-2.jpg", "car-3.jpg", "car-4.jpg", "car-5.jpg", "car-6.jpg", "car-1.jpg", "car-8.jpg", "car-9.jpg", "car-10.jpg", "car-11.jpg", "car-12.jpg"]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return carImages.count
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let image = UIImage(named: carImages[indexPath.row])
        let newSize: CGSize = CGSize(width: (image?.size.width)!/8, height: (image?.size.height)!/8)
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image?.drawInRect(rect)
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return(image2?.size)!
    }

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
    
        // Configure the cell
        let image = UIImage(named: carImages[indexPath.row])
        cell.imageView.image = image
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header: CollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as? CollectionReusableView
            header?.label.text = "McLaren P1"
        }
        
        return header!
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = collectionView?.indexPathForCell(sender as! CollectionViewCell)
            let detailVC = segue.destinationViewController as! DetailViewController
            detailVC.imageName = carImages[(indexPath?.row)!]
        }
    }
    
    @IBAction func share(sender: AnyObject) {
        var imageArray = [UIImage]()
        if !selectedImages.isEmpty {
            for imageName in selectedImages {
                imageArray.append(UIImage(named: imageName)!)
            }
            let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
            shareScreen.modalPresentationStyle = .Popover
            shareScreen.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
            presentViewController(shareScreen, animated: true, completion: nil)
        }
        
        
        sharing = !sharing
        collectionView?.allowsMultipleSelection = sharing
        collectionView?.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
        
        if !sharing {
            for cell in (collectionView?.visibleCells())! {
                cell.backgroundColor = UIColor.blackColor()
            }
            selectedImages.removeAll(keepCapacity: false)
        }
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if sharing {
            let image = carImages[indexPath.row]
            if let foundIndex = selectedImages.indexOf(carImages[indexPath.row]) {
                selectedImages.removeAtIndex(foundIndex)
                collectionView.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.blackColor()
            } else {
                selectedImages.append(image)
                collectionView.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.yellowColor()
            }
        } else {
            self.performSegueWithIdentifier("showDetail", sender: collectionView.cellForItemAtIndexPath(indexPath))
        }
        
        return false
    }


    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
