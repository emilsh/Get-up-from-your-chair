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
        let task = DataModel.createTask(with: getCurrentCard())
        realm.save(task)
        updatePlayButtonImage()
        updateNextNotificationLabel(with: task.endDate)
        tableView.reloadData()
      } else {
        isRunning = !isRunning
        storeApplicationState(isRunning)
        DataModel.removeLastTask()
        updateNextNotificationLabel(with: 0)
        updatePlayButtonImage()
        tableView.reloadData()
      }
    }
  
  //MARK: - Helper methods
  func getHoursMinutes(from date: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: date)
    return formatter.string(from: date)
  }
}

//MARK: - Notifications
extension ActivityViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound])
    let task = DataModel.createTask(with: getCurrentCard())
    realm.save(task)
    updateNextNotificationLabel(with: task.endDate)
    tableView.reloadData()
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let task = DataModel.createTask(with: getCurrentCard())
    realm.save(task)
    updateNextNotificationLabel(with: task.endDate)
    tableView.reloadData()
  }
}
