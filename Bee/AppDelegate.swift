//
//  AppDelegate.swift
//  Bee
//
//  Created by Ulan on 1/30/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit
import Fabric
import DigitsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DGTSessionUpdateDelegate {

    var window: UIWindow?

    func digitsSessionHasChanged(_ newSession: DGTSession!) {
        print(newSession.description)
    }
    func digitsSessionExpired(forUserID userID: String!) {
        print(userID)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Digits.self])
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        Digits.sharedInstance().sessionUpdateDelegate = self
        
        let tabbarController = UITabBarController()

        guard let navCon = self.window?.rootViewController as? UINavigationController else {
            return false
        }
        navCon.navigationBar.tintColor = .white
        navCon.navigationBar.barTintColor = UIColor.init(netHex: Colors.yellow)
        navCon.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navCon.navigationBar.shadowImage = UIImage()
       
        if UserDefaults.standard.bool(forKey: "isSignedIn"){
            navCon.viewControllers[0] = tabbarController.setTabbarController()
        }
        else{
            navCon.viewControllers[0] = LoginViewController.storyboardInstance()
        }
        
        return false
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

