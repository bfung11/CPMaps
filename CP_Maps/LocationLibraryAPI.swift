//
//  LocationLibraryAPI.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

// API that all classes and users use to interface with locations
// if model implementations change, classes can still continue to rely on
// on these functions and be oblivious to the change
class LocationLibraryAPI: NSObject {
   private let persistencyManager: PersistencyManager
   
   static let sharedInstance = LocationLibraryAPI()
   
   override init() {
      persistencyManager = PersistencyManager()
      
      super.init()
   }
   
   func addLocation(location: Location) {
      persistencyManager.addLocation(location)
   }
   
   func getLocation(index: Int) -> Location {
      return persistencyManager.getLocation(index)
   }
   
   func getAllLocations() -> [Location] {
      return persistencyManager.getAllLocations()
   }
   
   func getNumberOfLocations() -> Int {
      return persistencyManager.getNumberOfLocations()
   }
   
   func getBuilding(index: Int) -> Building {
      return persistencyManager.getBuilding(index)
   }
   
   func updateBuilding(#index: Int, #building: Building) {
      persistencyManager.updateBuilding(index: index, building: building)
   }
   
   func hasRoom(index: Int) -> Bool {
      return persistencyManager.hasRoom(index)
   }
   
   func getRoom(index: Int) -> Room? {
      return persistencyManager.getRoom(index)
   }
   
   func updateRoom(#index: Int, #room: Room) {
      persistencyManager.updateRoom(index: index, room: room)
   }
   
   func hasCourse(index: Int) -> Bool {
      return persistencyManager.hasCourse(index)
   }
   
   func getCourseName(index: Int) -> String {
      return persistencyManager.getCourseName(index)
   }
   
   func hasDays(index: Int) -> Bool {
      return persistencyManager.hasDays(index)
   }
   
   func getDays(index: Int) -> [Day]? {
      return persistencyManager.getDays(index)
   }
   
   func printAllLocations() {
      persistencyManager.printAllLocations()
   }
}
