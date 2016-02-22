//
//  AppDelegate.swift
//  tanzanite
//
//  Created by Goktug Yilmaz on 2/20/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit
import CoreLocation

let nest71Region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Nest72")
var beaconsList = []
var closeBeacons = [String]()
var closeBeaconsPrev = [String]()
var nearWhite = false
var nearBlue = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    var enteredRegion = false
    let viewController = ViewController()
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: nil))
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = viewController
        window!.backgroundColor = UIColor.whiteColor()
        window!.makeKeyAndVisible()

        return true
    }

    

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        beaconsList = beacons
        print("============================")
        
//        print(beacons)
        for beacon in beacons {
            var proximityString = ""
            switch beacon.proximity {
            case .Near: proximityString = "Near"
            case .Immediate: proximityString = "Immediate"
            case .Far: proximityString = "Far"
            case .Unknown: proximityString = "Unknown"
            }
            
            var beaconColor = ""
            switch beacon.major {
            case Int(31175): beaconColor = "Light Blue"
            case Int(21960): beaconColor = "Dark Blue"
            case Int(43886): beaconColor = "White"
            default: beaconColor = "Problem!!!!=========="
            }
            
            if beaconColor == "White" && (proximityString == "Near" || proximityString == "Immediate") {
                print("NEAR WHITE")
                closeBeacons.append("White")
            }
            
            if beaconColor == "Dark Blue" && (proximityString == "Near" || proximityString == "Immediate") {
                print("NEAR DARK BLUE")
                closeBeacons.append("Dark Blue")
            }
            
            
//            print("Major: \(beacon.major), Minor: \(beacon.minor), Color: \(beaconColor), Proximity: \(proximityString)")
        }
        
        print(closeBeacons)

        
        if closeBeacons.count == 0 {
            viewController.setBlank()
        }
        else if closeBeacons.count == 1 && closeBeacons[0] == "White" {
            viewController.setWhite()
        }
        else if closeBeacons.count == 1 && closeBeacons[0] == "Dark Blue" {
            viewController.setBlue()
        }
        else if closeBeacons.count > 1 {
            if closeBeaconsPrev.count == 1 && closeBeaconsPrev[0] == "White"
            {
                viewController.setBlue()
            }
            else if closeBeaconsPrev.count == 1 && closeBeaconsPrev[0] == "Dark Blue"
            {
                viewController.setWhite()
            }
            else
            {
                viewController.setMany()
            }
        }


        closeBeaconsPrev = closeBeacons
        closeBeacons = []

        
//        Major: 31175, Minor: 65488, Proximity: Unknown //light blue
//        Major: 21960, Minor: 29347, Proximity: Unknown //dark blue
//        Major: 43886, Minor: 64788, Proximity: Immediate //white
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .AuthorizedAlways:
            locationManager.startMonitoringForRegion(nest71Region)
            locationManager.startRangingBeaconsInRegion(nest71Region)
            locationManager.requestStateForRegion(nest71Region)
        case .Denied:
            let alert = UIAlertController(title: "Warning", message: "You've disabled location update which is required for this app to work. Go to your phone settings and change the permissions.", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
            alert.addAction(alertAction)
            
            self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        default:
            print("default case")
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        switch state {
        case .Unknown:
            print("unknown")
        case .Inside:
            var text : String = "Tap here to start coding."
            
            if enteredRegion {
                text = "Welcome to the best co-working space on the planet."
            }
            Notifications.display(text)
            print("inside")

        case .Outside:
            var text : String = "Why aren't you here? :("
            if !enteredRegion {
                text = "Wait! Don't go into the light."
            }
            Notifications.display(text)

            print("outside")
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        enteredRegion = true
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        enteredRegion = false
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

