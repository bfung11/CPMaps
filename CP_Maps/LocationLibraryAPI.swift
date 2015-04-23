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
   
   func hasName(index: Int) -> Bool {
      return persistencyManager.hasName(index)
   }
   
   func getName(index: Int) -> String {
      return persistencyManager.getName(index)
   }
   
   func updateName(#index: Int, name: String) {
      persistencyManager.updateName(index: index, name: name)
   }
   
   func getBuildingNumber(index: Int) -> String {
      return persistencyManager.getBuildingNumber(index)
   }
   
   func updateBuilding(#index: Int, #buildingNumber: String) {
      persistencyManager.updateBuilding(index: index, buildingNumber: buildingNumber)
   }
   
   func hasRoom(index: Int) -> Bool {
      return persistencyManager.hasRoom(index)
   }
   
   func getRoom(index: Int) -> String? {
      return persistencyManager.getRoomNumber(index)
   }
   
   func getRoomNumber(index: Int) -> String {
      return persistencyManager.getRoomNumber(index)
   }
   
   func updateRoomNumber(#index: Int, roomNumber: String) {
      persistencyManager.updateRoomNumber(index: index, roomNumber: roomNumber)
   }
   
   func hasDays(index: Int) -> Bool {
      return persistencyManager.hasDays(index)
   }
   
   func getDays(index: Int) -> String? {
      return persistencyManager.getDays(index)
   }
   
   func updateDays(#index: Int, days: String) {
      persistencyManager.updateDays(index: index, days: days)
   }
}
