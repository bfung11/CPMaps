//
//  Building.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/21/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Building: NSObject {
   var name: String!
   var number: String!
   var rooms: [Room]!
   
   init(name: String, number: String, rooms: [Room]) {
      self.name = name
      self.number = number
      self.rooms = rooms
      super.init()
   }
   
   init(building: Building) {
      self.name = building.name
      self.number = building.number
      self.rooms = building.rooms
      super.init()
   }
   
   func getBuildingName() -> String {
      return self.name
   }
   
   func getBuildingNumber() -> String {
      return self.number
   }
}
