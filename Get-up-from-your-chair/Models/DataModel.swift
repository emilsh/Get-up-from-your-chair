//
//  DataModel.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 25/6/21.
//
/*
import Foundation
import RealmSwift

class DataModel {
  
  static let shared = DataModel()
  
  private let realm: Realm
  
  private init() {
    realm = try! Realm()
  }
  
  func fetchTasks(for date: Date) -> [Task] {
    var dailyTasks: [Task] = []
    let currentDayInTimeInterval = date.extractYearMonthDayFromDate()!.timeIntervalSince1970
    let tasks = realm.objects(Task.self).filter({ task in
      task.date_start >= currentDayInTimeInterval && task.date_start <= currentDayInTimeInterval + 86400
    })
    for task in tasks {
      dailyTasks.append(task)
    }
    return dailyTasks
  }
  
  func save(_ task: Task) {
    task.id = lastId() + 1
    try! realm.write {
      realm.add(task)
    }
  }

}
*/
