//
//  LocationLibraryAPI.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

// API that all classes and users use to interface with locations
// calls persistencyMananger and not have code inside because this could also be for HTTP Clients
// should create all objects before passing to persistencyManager
// (i.e. get location or get string and create location before passing to persistencyManager)
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
   
   func hasRoom(index: Int) -> Bool {
      return persistencyManager.hasRoom(index)
   }
   
   func getRoom(index: Int) -> Room? {
      return persistencyManager.getRoom(index)
   }
   
   func printAllLocations() {
      persistencyManager.printAllLocations()
   }
}
