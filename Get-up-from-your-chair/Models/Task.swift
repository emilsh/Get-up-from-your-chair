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
  @objc dynamic var activity: Activity
  @objc dynamic var isDone: Bool
  @objc dynamic var startDate: TimeInterval
  @objc dynamic var endDate: TimeInterval
  
  init(activity: Activity, isDone: Bool, startDate: TimeInterval, endDate: TimeInterval) {
    self.activity = activity
    self.isDone = isDone
    self.startDate = startDate
    self.endDate = endDate
  }
  
  
  //MARK: - Notifications
  func scheduleNotification() {
    
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
