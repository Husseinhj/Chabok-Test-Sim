//
//  AppDelegate.swift
//  Chabok-Test-XS-Max
//
//  Created by Hussein Habibi Juybari on 1/22/19.
//  Copyright © 2019 Chabok Realtime Solutions. All rights reserved.
//

import UIKit
import AdpPushClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PushClientManagerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        PushClientManager.setDevelopment(true)
        //Reset badge and clear notification when app launched.
        PushClientManager.resetBadge()
        
        PushClientManager.default()?.addDelegate(self)
        
        //Initialize with credential keys
        let state = PushClientManager.default()?.registerApplication("chabok-starter",                    //based on your environment
            apiKey: "70df4ae2e1fd03518ce3e3b21ee7ca7943577749",         //based on your environment
            userName: "chabok-starter",  //based on your environment
            password: "chabok-starter")  //based on your environment
        
        if state == true {
            print("Initialized")
        } else {
            print("Not initialized")
        }
        
        PushClientManager.default()?.enableLog = true
        if PushClientManager.default()?.application(application, didFinishLaunchingWithOptions: launchOptions) == true {
            print("Launched by tapping on notification")
        }
        
        
        if let userId = PushClientManager.default()?.userId {
            PushClientManager.default()?.registerUser(userId)
        } else {
            PushClientManager.default()?.registerUser("USER_ID")
        }
        
        
        return true
    }
    
    //MARK : Notification AppDelegation
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle failure of get Device token from Apple APNS Server
        PushClientManager.default()?.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Handle receive Device Token From APNS Server
        PushClientManager.default()?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    @available(iOS 8.0, *)
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        // Handle iOS 8 remote Notificaiton Settings
        PushClientManager.default()?.application(application, didRegister: notificationSettings)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

