//
//  Task.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import Foundation
import UserNotifications

class Task {
  var activity: Activity // какая именно активность
  var isDone: Bool // выполнена или нет
  var date: TimeInterval // дата старта задачи – дата и время
  var duration: TimeInterval
  
  //var user: User // Если решим показывать рейтинг между пользователями
  
  init(activity: Activity, isDone: Bool, date: TimeInterval, duration: TimeInterval) {
    self.activity = activity
    self.isDone = isDone
    self.date = date
    self.duration = duration
  }
  
  
  //MARK: - Notifications
  func scheduleNotification() {
    
    let content = UNMutableNotificationContent()
    content.title = "Встань уже со стула"
    content.body = activity.name
    content.sound = UNNotificationSound.default
    
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
