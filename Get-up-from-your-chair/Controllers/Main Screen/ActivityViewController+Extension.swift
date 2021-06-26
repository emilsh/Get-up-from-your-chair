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
        let task = createNewTask()
        updatePlayButtonImage()
        updateNextNotificationLabel(with: task.endDate)
//        playPauseLabel.text = "Продолжить"
      } else {
        isRunning = !isRunning
        removeLastTask()
        updatePlayButtonImage()
//        playPauseLabel.text = "Остановить"
      }
    }
  
  //MARK: - Helper methods
  func getHoursMinutes(from date: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: date)
    return formatter.string(from: date)
  }
  
  func updatePlayButtonImage() {
    let imageName = isRunning ? "pause.fill" : "play.fill"
    playPauseLabel.text = isRunning ? "Остановить" : "Продолжить"
    playPauseButton.setImage(UIImage(systemName: imageName), for: .normal)
  }
  
  func updateNextNotificationLabel(with endDate: TimeInterval) {
    nextNotificationLabel.text = isRunning ? getHoursMinutes(from: endDate) : "остановлены"
    nextNotificationTextLabel.text = isRunning ? "Следующее:" : "Уведомления"
    nextNotificationLabel.textColor = isRunning ? .black : .gray
    nextNotificationTextLabel.textColor = isRunning ? .black : .gray
  }
  
  func updateUI() {
    guard let task = realm.getLastTask() else {
      isRunning = false
      return
    }
    isRunning = task.endDate > Date().timeIntervalSince1970 ? true : false
    updatePlayButtonImage()
    updateNextNotificationLabel(with: task.endDate)
    
    dailyTasks = realm.fetchDailyTasks(for: Date().timeIntervalSince1970)
  }
  
  func createNewTask() -> Task {
    let currentActivity = ActivityData.activities[0] // TODO: change to choose activity from cards
    let startDate = Date().timeIntervalSince1970
    let endDate = startDate + duration
    let task = Task(activity: currentActivity, isDone: false, startDate: startDate, endDate: endDate)
    realm.save(task)
    task.scheduleNotification()
//    updateNextNotificationLabel(with: endDate)
    return task
  }
  
  func removeLastTask() {
    guard let task = realm.getLastTask() else {
      return
    }
    realm.removeTask(task)
    task.removeNotification()
    updateNextNotificationLabel(with: 0)
  }
}
