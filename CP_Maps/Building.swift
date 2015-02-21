//
//  Building.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/21/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Building: NSObject {
   var name: String
   var number: String
   var room: String
   
   init(name: String, number: String, room: String) {
      self.name = name
      self.number = number
      self.room = room
      super.init()
   }
   
   init(building: Building) {
      self.name = building.name
      self.number = building.number
      self.room = building.room
      super.init()
   }
}
