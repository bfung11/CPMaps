//
//  PersistencyManager.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

// manager that controls all persistent objects
class LocationPersistencyManager: NSObject {
   private var locations: [Location]
   
   override init() {
      locations = locationsData as! [Location]
   }
   
   func addLocation(location: Location) {
      locations.append(location)
   }
   
   func getLocation(index: Int) -> Location {
      return locations[index]
   }
   
   func getAllLocations() -> [Location] {
      return locations
   }
   
   func getNumberOfLocations() -> Int {
      return locations.count
   }
   
   func hasName(index: Int) -> Bool {
      return locations[index].name != nil
   }
   
   func getName(index: Int) -> String {
      return locations[index].name!
   }
   
   func updateName(#index: Int, name: String) {
      locations[index].name = name
   }
   
   func getBuildingNumber(index: Int) -> String {
      return locations[index].buildingNumber
   }
   
   func updateBuilding(#index: Int, buildingNumber: String) {
      locations[index].buildingNumber = buildingNumber
   }
   
   func hasRoom(index: Int) -> Bool {
      return locations[index].roomNumber != nil
   }
   
   func getRoomNumber(index: Int) -> String {
      return locations[index].roomNumber!
   }
   
   func updateRoomNumber(#index: Int, roomNumber: String) {
      locations[index].roomNumber = roomNumber
   }
   
   func hasDays(index: Int) -> Bool {
      return locations[index].days != nil
   }
   
   func getDays(index: Int) -> String {
      return locations[index].days!
   }
   
   func updateDays(#index: Int, days: String) {
      locations[index].days = days
   }
}
