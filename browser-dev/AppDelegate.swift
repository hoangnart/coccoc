//
//  AppDelegate.swift
//  browser-dev
//
//  Created by hoangtv on 07/03/2023.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    if window == nil {
      window = UIWindow(frame: UIScreen.main.bounds)
    }
    window?.rootViewController = UIHostingController(rootView: SaveProgressMainView())
    window?.makeKeyAndVisible()
    return true
  }
  
  
}

