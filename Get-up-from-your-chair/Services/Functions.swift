//
//  Functions.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 26/6/21.
//

import Foundation

func storeDuration(_ duration: TimeInterval) {
  UserDefaults.standard.setValue(duration, forKey: "GetUpFromYourChairTimeDuration")
}

func getDuration() -> TimeInterval {
  UserDefaults.standard.double(forKey: "GetUpFromYourChairTimeDuration")
}

func registerDefaultDuration() {
  UserDefaults.standard.register(defaults: ["GetUpFromYourChairTimeDuration": 60])
}

func storeApplicationState(_ state: Bool) {
  UserDefaults.standard.setValue(state, forKey: "GetUpFromYourChairAppState")
}

func getApplicationState() -> Bool {
  UserDefaults.standard.bool(forKey: "GetUpFromYourChairAppState")
}

func getCurrentCardIndex() -> Int {
  UserDefaults.standard.integer(forKey: "GetUpFromYourChairCurrentCard")
}

func storeCurrentCardIndex(_ index: Int) {
  UserDefaults.standard.setValue(index, forKey: "GetUpFromYourChairCurrentCard")
}

enum Duration: TimeInterval {
  case fifteen = 900
  case thirty = 1800
  case sixty = 3600
  case ninety = 5400
}

enum DaysAgo: TimeInterval, CaseIterable {
  case sevenDays = 518400
  case sixDays = 432000
  case fiveDays = 345600
  case fourDays = 259200
  case threeDays = 172800
  case twoDays = 86400
  case oneDay = 0
}
