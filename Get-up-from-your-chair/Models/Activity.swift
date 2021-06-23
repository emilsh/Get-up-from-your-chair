//
//  Activity.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import Foundation

class Activity {
  var name: String
  var image: Data?
  var description: String
  
  init(name: String, image: Data?, description: String) {
    self.name = name
    self.image = image
    self.description = description
  }
}
