//
//  Activity.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import Foundation
import RealmSwift

class Activity: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var image: Data?
  @objc dynamic var activityDescription: String = ""
  
  convenience init(name: String, image: Data?, description: String) {
    self.init()
    self.name = name
    self.image = image
    self.activityDescription = description
  }
}

struct ActivityData {
  static let activities: [Activity] = [
    Activity(name: "Погуляйте 5 минут",
             image: UIImage(systemName: "figure.walk")?.pngData(),
             description: "Даже в небольших помещениях хождение по периметру или марш на месте могут помочь вам оставаться активными"),
    Activity(name: "Проведите 5 минут в стоячем положении",
             image: UIImage(systemName: "figure.stand")?.pngData(),
             description: "Сократите время, проводимое в сидячем положении, и по возможности отдавайте предпочтение положению стоя")
  ]
}
