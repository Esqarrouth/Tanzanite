//
//  ViewController.swift
//  tanzanite
//
//  Created by Goktug Yilmaz on 2/20/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    var scrollView: UIScrollView!
    var currImage: String!
    var currentImage: UIImageView!
    var secondImageOpen = false
    var lastImage: UIImage!
    
    var firstImages = [UIImage(named: "home"), UIImage(named: "exhibition"), UIImage(named: "allVenues"), UIImage(named: "listBlue")]
    var currentImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.backgroundColor = UIColor.whiteColor()
        
        currentImage = UIImageView(x: 0, y: 0, image: firstImages[0]!, scaleToWidth: screenWidth)
        currentImage.userInteractionEnabled = true
        currentImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapped"))
        
        scrollView.addSubview(currentImage)
        scrollView.contentSize = CGSize(width: screenWidth, height: currentImage.frame.height)

        currImage = "allVenues"
        
        view.addSubview(scrollView)
    }
    
    func firstTap() {
        
    }
        
    func tapped() {
        if currentImageIndex < 3 {
            currentImageIndex++
            currentImage.image = firstImages[currentImageIndex]
        } else {
            if secondImageOpen {
                secondImageOpen = false
                currentImage.image = lastImage
            } else {
                secondImageOpen = true
                currentImage.image = UIImage(named: "screenBlue")
            }
        }
        
        currentImage.scaleImageFrameToWidth(width: screenWidth)
        scrollView.contentSize = CGSize(width: screenWidth, height: currentImage.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }

    var waitingForDelay = false
    func setBlue(){
        guard currentImageIndex > 2 else { return }
        guard !secondImageOpen else { return }
        currImage = "listBlue"
        currentImage.image = UIImage(named: "heart")
        currentImage.scaleImageFrameToWidth(width: screenWidth)
        scrollView.contentSize = CGSize(width: screenWidth, height: currentImage.frame.height)
        lastImage = currentImage.image
        waitingForDelay = true
        runThisAfterDelay(seconds: 3) { () -> () in
            self.currImage = "listBlue"
            self.currentImage.image = UIImage(named: "listBlue")
            self.currentImage.scaleImageFrameToWidth(width: screenWidth)
            self.scrollView.contentSize = CGSize(width: screenWidth, height: self.currentImage.frame.height)
            self.lastImage = self.currentImage.image
            self.waitingForDelay = false
        }
    }
    
    func setWhite(){
        guard currentImageIndex > 2 else { return }
        guard !secondImageOpen else { return }
        currImage = "listWhite"
        currentImage.image = UIImage(named: "listWhite")
        currentImage.scaleImageFrameToWidth(width: screenWidth)
        scrollView.contentSize = CGSize(width: screenWidth, height: currentImage.frame.height)
        lastImage = currentImage.image
    }

    func setMany(){
        guard currentImageIndex > 2 else { return }
        guard !secondImageOpen else { return }
        if currImage == "cat" {
            currentImage.image = UIImage(named: "listWhite")
            currentImage.scaleImageFrameToWidth(width: screenWidth)
            scrollView.contentSize = CGSize(width: screenWidth, height: currentImage.frame.height)
            lastImage = currentImage.image
        }
    }
    
    func setBlank(){
        guard currentImageIndex > 2 else { return }
        guard !secondImageOpen else { return }
        currImage = "cat"
        currentImage.image = UIImage(data: NSData())
        lastImage = currentImage.image
    }
    

}

/// EZSE: Returns current screen orientation
public var screenOrientation: UIInterfaceOrientation {
    return UIApplication.sharedApplication().statusBarOrientation
}

/// EZSE: Returns screen width
public var screenWidth: CGFloat {
    if UIInterfaceOrientationIsPortrait(screenOrientation) {
        return UIScreen.mainScreen().bounds.size.width
    } else {
        return UIScreen.mainScreen().bounds.size.height
    }
}

/// EZSE: Returns screen height
public var screenHeight: CGFloat {
    if UIInterfaceOrientationIsPortrait(screenOrientation) {
        return UIScreen.mainScreen().bounds.size.height
    } else {
        return UIScreen.mainScreen().bounds.size.width
    }
}

/// EZSE: runs function after x seconds
public func runThisAfterDelay(seconds seconds: Double, after: () -> ()) {
    runThisAfterDelay(seconds: seconds, queue: dispatch_get_main_queue(), after: after)
}

//TODO: Make this easier
/// EZSE: runs function after x seconds with dispatch_queue, use this syntax: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
public func runThisAfterDelay(seconds seconds: Double, queue: dispatch_queue_t, after: ()->()) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(time, queue, after)
}

