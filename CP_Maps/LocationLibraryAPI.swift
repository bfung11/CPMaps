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
class LocationsLibraryAPI: NSObject {
   private let locationsPersistencyManager: LocationsPersistencyManager
   private let buildingsPersistencyManager: BuildingsPersistencyManager
   
   static let sharedInstance = LocationsLibraryAPI()
   
   override init() {
      locationsPersistencyManager = LocationsPersistencyManager()
      buildingsPersistencyManager = BuildingsPersistencyManager()
      super.init()
   }
   
   func addLocation(location: Location) {
      locationsPersistencyManager.addLocation(location)
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
   
   func hasName(index: Int) -> Bool {
      return locationsPersistencyManager.hasName(index)
   }
   
   func getName(index: Int) -> String {
      return locationsPersistencyManager.getName(index)
   }
   
   func updateName(#index: Int, name: String) {
      locationsPersistencyManager.updateName(index: index, name: name)
   }
   
//   func addBuilding(building: Building) {
//      buildingsPersistencyManager.addBuilding(building)
//   }
   
   func getBuildingName(index: Int) -> String {
      return buildingsPersistencyManager.getBuildingName(index)
   }
   
   func getBuildingNumber(index: Int) -> String {
      return locationsPersistencyManager.getBuildingNumber(index)
   }
   
   func updateBuildingNumber(#index: Int, #buildingNumber: String) {
      locationsPersistencyManager.updateBuilding(index: index, buildingNumber: buildingNumber)
   }
   
   func hasRoom(index: Int) -> Bool {
      return locationsPersistencyManager.hasRoom(index)
   }
   
   func getRoom(index: Int) -> String? {
      return locationsPersistencyManager.getRoomNumber(index)
   }
   
   func getRoomNumber(index: Int) -> String {
      return locationsPersistencyManager.getRoomNumber(index)
   }
   
   func updateRoomNumber(#index: Int, roomNumber: String) {
      locationsPersistencyManager.updateRoomNumber(index: index, roomNumber: roomNumber)
   }
   
   func hasDays(index: Int) -> Bool {
      return locationsPersistencyManager.hasDays(index)
   }
   
   func getDays(index: Int) -> String? {
      return locationsPersistencyManager.getDays(index)
   }
   
   func updateDays(#index: Int, days: String) {
      locationsPersistencyManager.updateDays(index: index, days: days)
   }
}
