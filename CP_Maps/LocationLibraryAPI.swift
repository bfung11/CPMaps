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
   private let locationPersistencyManager: LocationPersistencyManager
   private let buildingPersistencyManager: BuildingPersistencyManager
   
   static let sharedInstance = LocationLibraryAPI()
   
   override init() {
      locationPersistencyManager = LocationPersistencyManager()
      buildingPersistencyManager = BuildingPersistencyManager()
      super.init()
   }
   
   func addLocation(location: Location) {
      locationPersistencyManager.addLocation(location)
   }
   
   func getLocation(index: Int) -> Location {
      return locationPersistencyManager.getLocation(index)
   }
   
   func getAllLocations() -> [Location] {
      return locationPersistencyManager.getAllLocations()
   }
   
   func getNumberOfLocations() -> Int {
      return locationPersistencyManager.getNumberOfLocations()
   }
   
   func hasLocationName(index: Int) -> Bool {
      return locationPersistencyManager.hasName(index)
   }
   
   func getLocationName(index: Int) -> String {
      return locationPersistencyManager.getName(index)
   }
   
   func updateLocationName(#index: Int, name: String) {
      locationPersistencyManager.updateName(index: index, name: name)
   }
   
   func getLocationBuildingNumber(index: Int) -> String {
      return locationPersistencyManager.getBuildingNumber(index)
   }
   
   func updateLocationBuilding(#index: Int, #buildingNumber: String) {
      locationPersistencyManager.updateBuilding(index: index, buildingNumber: buildingNumber)
   }
   
   func hasLocationRoom(index: Int) -> Bool {
      return locationPersistencyManager.hasRoom(index)
   }
   
   func getLocationRoom(index: Int) -> String? {
      return locationPersistencyManager.getRoomNumber(index)
   }
   
   func getLocationRoomNumber(index: Int) -> String {
      return locationPersistencyManager.getRoomNumber(index)
   }
   
   func updateLocationRoomNumber(#index: Int, roomNumber: String) {
      locationPersistencyManager.updateRoomNumber(index: index, roomNumber: roomNumber)
   }
   
   func hasLocationDays(index: Int) -> Bool {
      return locationPersistencyManager.hasDays(index)
   }
   
   func getLocationDays(index: Int) -> String? {
      return locationPersistencyManager.getDays(index)
   }
   
   func updateLocationDays(#index: Int, days: String) {
      locationPersistencyManager.updateDays(index: index, days: days)
   }
   
   func addBuilding(building: Building) {
      buildingPersistencyManager.addBuilding(building)
   }
   
   func getBuildingName(index: Int) -> String {
      return buildingPersistencyManager.getBuildingName(index)
   }
   
   func getBuildingNumber(index: Int) -> String {
      return buildingPersistencyManager.getBuildingNumber(index)
   }
}
