//
//  Functions.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 26/6/21.
//

import Foundation

func storeDuration(_ duration: TimeInterval) {
  UserDefaults.standard.setValue(duration, forKey: "TimeDuration")
}

func getDuration() -> TimeInterval {
  UserDefaults.standard.double(forKey: "TimeDuration")
}

func registerDefaultDuration() {
  UserDefaults.standard.register(defaults: ["TimeDuration": 3600])
}
