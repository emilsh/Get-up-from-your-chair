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
      var task = realm.getLastTask()
      if !isRunning {
        let currentActivity = ActivityData.activities[0] // TODO: change to choose activity from cards
        let startDate = Date().timeIntervalSince1970
        let endDate = startDate + duration
        task = Task(activity: currentActivity, isDone: false, startDate: startDate, endDate: endDate)
        realm.save(task!)
        task?.scheduleNotification()
        
        nextNotificationLabel.text = getHoursMinutes(from: endDate)
        playPauseButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        isRunning = !isRunning
      } else {
        guard let task = task else {
          fatalError("Cannot get last task")
        }
        realm.removeTask(task)
        task.removeNotification()
        
        nextNotificationLabel.text = ""
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        isRunning = !isRunning
      }
    }
  
  //MARK: - Helper methods
  func getHoursMinutes(from date: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: date)
    return formatter.string(from: date)
  }


}

