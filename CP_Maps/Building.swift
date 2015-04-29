//
//  Building.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/21/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

class Building: NSObject {
   var name: String!
   var number: String!
   var rooms: [Room]!
   var latitude: Double!
   var longitude: Double!
   
   init(name: String, number: String, rooms: [Room]) {
      self.name = name
      self.number = number
      self.rooms = rooms
      super.init()
   }
   
   init(name: String, number: String, lat: Double, long: Double) {
      self.name = name
      self.number = number
      self.rooms = []
      self.latitude = lat
      self.longitude = long
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
   
   func getLongtitude() -> Double {
      return self.longitude
   }
   
   func getLatitude() -> Double {
      return self.latitude
   }
}
