//
//  Task.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import Foundation
import UserNotifications

class Task {
  var activity: Activity
  var isDone: Bool
  var startDate: TimeInterval
  var endDate: TimeInterval
  
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
