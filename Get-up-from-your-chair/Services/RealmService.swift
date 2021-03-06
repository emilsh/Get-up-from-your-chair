//
//  DataModel.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 25/6/21.
//

import Foundation
import RealmSwift

class RealmService {
  private let oneDayInSeconds: TimeInterval = 86400
  
  static let shared = RealmService()
  
  private let realm: Realm
  
  private init() {
    realm = try! Realm()
  }
  
  func fetchDailyTasks(for date: TimeInterval) -> [Task] {
    var dailyTasks: [Task] = []
    
    let currentDate = Date(timeIntervalSince1970: date)
    guard let currentDay = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: currentDate) else {
      fatalError("Cannot convert date")
    }
    let dateInterval = DateInterval(start: currentDay, duration: oneDayInSeconds)
    
    let tasks = realm.objects(Task.self).filter({ task in
      dateInterval.contains(Date(timeIntervalSince1970: task.endDate))
    })
    for task in tasks {
      dailyTasks.append(task)
    }
    return dailyTasks
  }
  
  func getLastTask() -> Task? {
    return realm.objects(Task.self).last
  }
  
  func save(_ task: Task) {
    task.id = lastId() + 1
    try! realm.write {
      realm.add(task)
    }
  }
  
  func toggleState(for task: Task) {
    try! realm.write {
      task.isDone = !task.isDone
    }
  }
  
  func markTaskDone(_ task: Task) {
    try! realm.write {
      task.isDone = true
    }
  }
  
  func markTaskUnDone(_ task: Task) {
    try! realm.write {
      task.isDone = false
    }
  }
  
  func getCountOfActivities(for day: TimeInterval) -> Int {
    let date = Date().timeIntervalSince1970 - day
    let tasks = fetchDailyTasks(for: date)
    return tasks.filter { $0.isDone }.count
    
  }
  
  func removeTask(_ task: Task) {
    try! realm.write {
      realm.delete(task)
    }
  }
  
  func lastId() -> Int {
    guard let lastId = realm.objects(Task.self).last?.id else { return -1 }
    return lastId
  }

}
