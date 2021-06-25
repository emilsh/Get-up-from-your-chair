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
        playPauseButton.setImage(UIImage(systemName: ""), for: .normal) // TODO: UIImage(systemName:) change argument to "pause image"
        isRunning = !isRunning
      } else {
        task?.removeNotification()
        
        playPauseButton.setImage(UIImage(systemName: ""), for: .normal) // TODO: UIImage(systemName:) change argument to "play image"
        isRunning = !isRunning
      }
    }
  
  //MARK: - Helper methods
  func getHoursMinutes(from date: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: date)
    return formatter.string(from: date)
  }


}

