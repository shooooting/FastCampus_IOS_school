//
//  AppDelegate.swift
//  CombinationTableCollectionView
//
//  Created by 김광수 on 2020/06/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds) 
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
    
    return true
  }


}

