//
//  DataModel.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 30/6/21.
//

import Foundation

class DataModel {
  
  static func createTask(with cardIndex: Int) -> Task {
    let currentCardIndex = cardIndex
    let currentActivity = ActivityData.activities[currentCardIndex]
    let duration = getDuration()
    let startDate = Date().timeIntervalSince1970
    let endDate = startDate + duration
    let task =  Task(activity: currentActivity, isDone: false, startDate: startDate, endDate: endDate)
    task.scheduleNotification()
    return task
  }
 
  static func removeLastTask() {
    let realm = RealmService.shared
    guard let task = realm.getLastTask() else {
      return
    }
    realm.removeTask(task)
    task.removeNotification()
  }
}
