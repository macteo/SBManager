//
//  AppDelegate.swift
//  status-replacer
//
//  Created by Matteo Gavagnin on 04/12/14.
//  Copyright (c) 2014 MacTeo. All rights reserved.
//

import UIKit
import SBManager

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        StatusBarManager.sharedInstance
        return true
    }
}

