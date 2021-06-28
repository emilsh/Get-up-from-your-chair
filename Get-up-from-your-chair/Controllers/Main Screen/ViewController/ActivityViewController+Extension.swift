//
//  ActivityViewController+Extension.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 26/6/21.
//

import UIKit

extension ActivityViewController {
  
  //MARK: Actions
    @IBAction func playButtonTapped(_ sender: Any) {
      if !isRunning {
        isRunning = !isRunning
        storeApplicationState(isRunning)
        let task = createNewTask()
        updatePlayButtonImage()
        updateNextNotificationLabel(with: task.endDate)
      } else {
        isRunning = !isRunning
        storeApplicationState(isRunning)
        removeLastTask()
        updatePlayButtonImage()
      }
    }
  
  //MARK: - Helper methods
  func getHoursMinutes(from date: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: date)
    return formatter.string(from: date)
  }
  
  func createNewTask() -> Task {
    let currentCardIndex = getCurrentCard()
    let currentActivity = ActivityData.activities[currentCardIndex]
    let startDate = Date().timeIntervalSince1970
    let endDate = startDate + duration
    let task = Task(activity: currentActivity, isDone: false, startDate: startDate, endDate: endDate)
    realm.save(task)
    task.scheduleNotification()
    updateNextNotificationLabel(with: endDate)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .bottom)
    return task
  }
  
  func removeLastTask() {
    guard let task = realm.getLastTask() else {
      return
    }
    realm.removeTask(task)
    task.removeNotification()
    updateNextNotificationLabel(with: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.deleteRows(at: [indexPath], with: .bottom)
    
  }
}

//MARK: - Notifications
extension ActivityViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound])
    let _ = createNewTask()
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let _ = createNewTask()
  }
}
