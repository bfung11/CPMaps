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
   var numberOfFloors: Int!
   var rooms: [Room]!
   var latitude: Double!
   var longitude: Double!
   
   init(name: String, number: String, rooms: [Room]) {
      self.name = name
      self.number = number
      self.rooms = rooms
      super.init()
   }
   
   init(number: String, name: String) {
      self.name = name
      self.number = number
      self.numberOfFloors = 0
      self.rooms = []
      super.init()
   }
   
   init(number: String, name: String, numberOfFloors: Int, latitude: Double, longitude: Double) {
      self.name = name
      self.number = number
      self.numberOfFloors = numberOfFloors
      self.rooms = []
      self.latitude = latitude
      self.longitude = longitude
      super.init()
   }
   
   init(building: Building) {
      self.name = building.name
      self.number = building.number
      self.rooms = building.rooms
      self.numberOfFloors = building.numberOfFloors
      self.latitude = building.latitude
      self.longitude = building.longitude
      super.init()
   }
   
   func getName() -> String {
      return self.name
   }
   
   func getNumber() -> String {
      return self.number
   }
   
   func getNumberOfFloors() -> Int {
      return self.numberOfFloors
   }
   
   func getLongtitude() -> Double {
      return self.longitude
   }
   
   func getLatitude() -> Double {
      return self.latitude
   }
}
