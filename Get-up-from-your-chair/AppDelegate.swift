//
//  AppDelegate.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { _, _ in
      
    }
//    center.delegate = self
    
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
    return UISceneConfiguration(name: "Default Configuration",
                                sessionRole: connectingSceneSession.role)
  }
}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let activityVC = mainStoryboard.instantiateViewController(identifier: "ActivityViewController") as! ActivityViewController
//    let _ = activityVC.createNewTask()
//  }
//}
