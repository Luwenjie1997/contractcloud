//
//  AppDelegate.swift
//  myContract
//
//  Created by 卢文杰 on 2019/4/27.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //重写openURL
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return TencentOAuth.handleOpen(url)
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LCApplication.default.set(
            id:  "WN8N4j7uVJa7kqXtuXU7ws5b-gzGzoHsz",
            key: "9xQN8PC5n6gC9oysQGanPdS8"
        )
        
        
        
        return true
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let path = url.absoluteString
        let string = NSMutableString.init(string: path)
        if path.hasPrefix("file://"){
            string.replaceOccurrences(of: "file://", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, path.count))
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pdf"), object: string)
//        return true
        return TencentOAuth.handleOpen(url)
    }


}

