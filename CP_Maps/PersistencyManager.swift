//
//  PersistencyManager.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

// manager that controls all persistent objects
class PersistencyManager: NSObject {
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
   
   func getBuilding(index: Int) -> Building {
      return locations[index].building
   }
   
   func hasRoom(index: Int) -> Bool {
      return locations[index].room != nil
   }
   
   func getRoom(index: Int) -> Room? {
      return locations[index].room
   }
   
   func hasCourse(index: Int) -> Bool {
      return locations[index].course != nil
   }
   
   func getCourseName(index: Int) -> String {
      return locations[index].course!.name
   }
   
   func printAllLocations() {
      for location in locations {
         println(location.building!.name + " ")
      }
   }
}
