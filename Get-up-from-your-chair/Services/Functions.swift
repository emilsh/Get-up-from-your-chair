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

enum Duration: TimeInterval {
  case fifteen = 900
  case thirty = 1800
  case sixty = 3600
  case ninety = 5400
}
