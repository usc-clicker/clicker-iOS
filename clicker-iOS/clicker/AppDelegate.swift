//
//  AppDelegate.swift
//  clicker
//
//  Created by Wayne Chi on 9/17/15.
//  Copyright (c) 2015 Univeristy of Southern California. All rights reserved.
//

import Parse
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
        
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.addUniqueObject("Students", forKey: "channels")
        currentInstallation.saveInBackground()
}
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
//        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
        
        let rootViewController = self.window!.rootViewController as! UINavigationController
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : JLMultipleChoiceViewController = storyboard.instantiateViewControllerWithIdentifier("MultipleChoiceViewController") as! JLMultipleChoiceViewController
        NSLog("userinfo: %@", userInfo);
        let questionString = userInfo["question"] as! String;
        let timeLimit = userInfo["time_limit"] as! NSNumber;
        let choicesArray = userInfo["choices"] as! NSArray;
        let questionID = userInfo["id"] as! NSNumber;
        vc.questionString = questionString;
        vc.timeLimit = timeLimit;
        vc.answersArray = choicesArray as [AnyObject];
        vc.questionID = questionID.integerValue;
        
        
        let navigationController = UINavigationController(rootViewController: vc)
        
        rootViewController.presentViewController(navigationController, animated: true, completion: nil)
        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Parse ID
        Parse.setApplicationId("4dWxGYc9wzZRtcxzL3wXne6gmJiLfKut5AA4H4xL",
            clientKey: "e8t0sCOUyo8FFD7RuDUq6GIS4ccJ51GxQX17P15p")
        
//        self.window!.tintColor = UIColor.whiteColor()
//        UINavigationBar.appearance().setBackgroundImage(nil, forBarMetrics: UIBarMetrics.DefaultPrompt);
        UINavigationBar.appearance().backgroundColor = UIColor.redColor();
        UINavigationBar.appearance().translucent = false;

        // Register for Push Notitications
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let userNotificationTypes = UIUserNotificationType.Alert.union(UIUserNotificationType.Badge).union(UIUserNotificationType.Sound)
//            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
//            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
            let types = UIRemoteNotificationType.Badge.union(UIRemoteNotificationType.Alert).union(UIRemoteNotificationType.Sound)
            application.registerForRemoteNotificationTypes(types)
        }
        
//        let currentInstallation = PFInstallation.currentInstallation()
//        currentInstallation.addUniqueObject("Students", forKey: "channels")
//        currentInstallation.saveInBackground()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
//        let currentInstallation = PFInstallation.currentInstallation()
//        currentInstallation.addUniqueObject("Students", forKey: "channels")
//        currentInstallation.saveInBackground()
        
//        let push = PFPush()
//        push.setChannel("Students")
//        push.setMessage("WAIT WTF IT WORKS")
//        push.sendPushInBackground()
        
//        let currentInstallation = PFInstallation.currentInstallation()
//        currentInstallation.addUniqueObject("Students", forKey: "channels")
//        currentInstallation.saveInBackground()
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
//        let currentInstallation = PFInstallation.currentInstallation()
//        currentInstallation.addUniqueObject("Students", forKey: "channels")
//        currentInstallation.saveInBackground()
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
//        let currentInstallation = PFInstallation.currentInstallation()
//        currentInstallation.addUniqueObject("Students", forKey: "channels")
//        currentInstallation.saveInBackground()
       
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

