//
//  Notifications.swift
//  tanzanite
//
//  Created by Goktug Yilmaz on 2/20/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit

class Notifications {
    
    class func display(text: String){
        
        let notification: UILocalNotification = UILocalNotification()
        notification.timeZone = NSTimeZone.defaultTimeZone()
        
        let dateTime = NSDate()
        notification.fireDate = dateTime
        notification.alertBody = text
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
}
