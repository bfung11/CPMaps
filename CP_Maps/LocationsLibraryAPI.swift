//
//  LocationLibraryAPI.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

// API that all classes and users use to interface with locations
// if model implementations change, classes can still continue to rely on
// on these functions and be oblivious to the change
class LocationsLibraryAPI: NSObject {
   private let locationsPersistencyManager: LocationsPersistencyManager
   private let buildingsPersistencyManager: BuildingsPersistencyManager
   
   static let sharedInstance = LocationsLibraryAPI()
   
   override init() {
      locationsPersistencyManager = LocationsPersistencyManager()
      buildingsPersistencyManager = BuildingsPersistencyManager()
      super.init()
   }
   
   func addLocation(name: String, buildingNumber: String, roomNumber: String, startTime: String, endTime: String, days: String,
      insertIntoManagedObjectContext context: NSManagedObjectContext) {
      locationsPersistencyManager.addLocation(name, buildingNumber: buildingNumber, roomNumber: roomNumber, startTime: startTime, endTime: endTime, days: days, insertIntoManagedObjectContext: context)
   }
   
   func getLocation(index: Int) -> Location {
      return locationsPersistencyManager.getLocation(index)
   }
   
   func getAllLocations() -> [Location] {
      return locationsPersistencyManager.getAllLocations()
   }
   
   func getNumberOfLocations() -> Int {
      return locationsPersistencyManager.getNumberOfLocations()
   }
   
   func locationHasName(index: Int) -> Bool {
      return locationsPersistencyManager.hasName(index)
   }
   
   func getLocationName(index: Int) -> String {
      return locationsPersistencyManager.getName(index)
   }
   
   func updateLocationName(#index: Int, name: String) {
      locationsPersistencyManager.updateName(index: index, name: name)
   }
   
//   func addBuilding(building: Building) {
//      buildingsPersistencyManager.addBuilding(building)
//   }
   
   func getLocationBuildingName(index: Int) -> String {
      return buildingsPersistencyManager.getBuildingName(index)
   }
   
   func getLocationBuildingNumber(index: Int) -> String {
      return locationsPersistencyManager.getBuildingNumber(index)
   }
   
   func updateLocationBuildingNumber(#index: Int, buildingNumber: String) {
      locationsPersistencyManager.updateBuildingNumber(index: index, buildingNumber: buildingNumber)
   }
   
   func locationHasRoom(index: Int) -> Bool {
      return locationsPersistencyManager.hasRoom(index)
   }
   
   func getLocationRoom(index: Int) -> String? {
      return locationsPersistencyManager.getRoomNumber(index)
   }
   
   func getLocationRoomNumber(index: Int) -> String {
      return locationsPersistencyManager.getRoomNumber(index)
   }
   
   func updateLocationRoomNumber(#index: Int, roomNumber: String) {
      locationsPersistencyManager.updateRoomNumber(index: index, roomNumber: roomNumber)
   }
   
   func locationHasDays(index: Int) -> Bool {
      return locationsPersistencyManager.hasDays(index)
   }
   
   func getLocationDays(index: Int) -> String? {
      return locationsPersistencyManager.getDays(index)
   }
   
   func updateLocationDays(#index: Int, days: String) {
      locationsPersistencyManager.updateDays(index: index, days: days)
   }
}
