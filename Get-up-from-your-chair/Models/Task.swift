//
//  Task.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import Foundation
import UserNotifications
import RealmSwift

class Task: Object {
  @objc dynamic var id: Int = -1
  @objc dynamic var activity: Activity?
  @objc dynamic var isDone: Bool = false
  @objc dynamic var startDate: TimeInterval = 0.0
  @objc dynamic var endDate: TimeInterval = 0.0
  
  convenience init(activity: Activity, isDone: Bool, startDate: TimeInterval, endDate: TimeInterval) {
    self.init()
    self.activity = activity
    self.isDone = isDone
    self.startDate = startDate
    self.endDate = endDate
  }
  
  
  //MARK: - Notifications
  func scheduleNotification() {
    
    guard let activity = activity else {
      fatalError("No choosed activity")
    }
    
    let content = UNMutableNotificationContent()
    content.title = "Встань уже со стула"
    content.body = activity.name
    content.sound = UNNotificationSound.default
    let duration = endDate - startDate
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats: true)
    let request = UNNotificationRequest(identifier: "TaskActivity", content: content, trigger: trigger)
    let center = UNUserNotificationCenter.current()
    center.add(request)
  }
  
  func removeNotification() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["TaskActivity"])
    
  }
}
