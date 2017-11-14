//
//  AppDelegate.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD

/**
 *  Application Delegate
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /**
     * Main window
     */
    var window: UIWindow?
    
    // Setup
    
    /**
     *  buildApplication()
     *  @description    Customizes application
     */
    func buildApplication() {
        
        // Status bar
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // Navigation Bar custom colors
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        
        // ProgressHUD custom colors
        SVProgressHUD.setBackgroundColor(UIColor.navigationBarColor)
        SVProgressHUD.setForegroundColor(UIColor.white)
        
        // Prepare root controller
        if  let navigationController = window!.rootViewController as? UINavigationController,
            let repositoriesController = navigationController.viewControllers.first as? RepositoriesViewController {
            repositoriesController.viewModel = RepositoriesViewModel()
        }
    }
    
    // MARK: - 👽 Lifecycle Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        buildApplication()
        return true
    }
    
    // MARK: - 🎃 Reachability Listeners
    func applicationDidBecomeActive(_ application: UIApplication) {
        ReachabilityManager.subscribe()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        ReachabilityManager.unsubscribe()
    }
}

