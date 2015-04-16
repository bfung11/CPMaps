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
   
   func getBuildingName(index: Int) -> String {
      return locations[index].building.getBuildingName()
   }
   
   func getBuildingNumber(index: Int) -> String {
      return locations[index].building!.getBuildingNumber()
   }
   
   func updateBuilding(#index: Int, building: Building) {
      locations[index].building = building
   }
   
   func hasRoom(index: Int) -> Bool {
      return locations[index].room != nil
   }
   
   func getRoom(index: Int) -> Room? {
      return locations[index].room
   }
   
   func getRoomNumber(index: Int) -> String {
      return locations[index].room!.getRoomNumber()
   }
   
   func updateRoom(#index: Int, room: Room) {
      locations[index].room = room
   }
   
   func hasCourse(index: Int) -> Bool {
      return locations[index].course != nil
   }
   
   func getCourseName(index: Int) -> String {
      return locations[index].course!.getCourseName()
   }
   
   func getCourseDetails(index: Int) -> String {
      return locations[index].getCourseDetails()
   }
   
   func updateCourse(#index: Int, course: Course) {
      locations[index].course = course
   }
   
   func hasDays(index: Int) -> Bool {
      return locations[index].course!.hasDays()
   }
   
   func getDays(index: Int) -> [Day]? {
      return locations[index].course!.days
   }
   
   func printAllLocations() {
      for location in locations {
         println(location.building!.name + " ")
      }
   }
}
