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
class CPMapsLibraryAPI: NSObject {
   private let locationsPersistencyManager: LocationsPersistencyManager
   private let buildingsPersistencyManager: BuildingsPersistencyManager
   private let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

   static let sharedInstance = CPMapsLibraryAPI()
   
   override init() {
      locationsPersistencyManager = LocationsPersistencyManager()
      buildingsPersistencyManager = BuildingsPersistencyManager()
      super.init()
   }
   
   func loadDataFromCSV() {
      buildingsPersistencyManager.loadDataFromCSV()
   }
   
   func getNSFetchedResultsController() -> NSFetchedResultsController {
      return locationsPersistencyManager.getNSFetchedResultsController()
   }
   
   func setDelegate(delegate: NSFetchedResultsControllerDelegate) {
      locationsPersistencyManager.setDelegate(delegate)
   }
   
   func addLocation(name: String?, buildingNumber: String!, roomNumber: String?, startTime: String?, endTime: String?, days: String?) {
      locationsPersistencyManager.addLocation(name, buildingNumber: buildingNumber, roomNumber: roomNumber, startTime: startTime, endTime: endTime, days: days, context: managedObjectContext)
   }
   
   func getLocation(indexPath: NSIndexPath) -> Location {
      return locationsPersistencyManager.getLocation(indexPath)
   }
   
   func getBuilding(buildingNumber: String) -> Building {
      return buildingsPersistencyManager.getBuilding(buildingNumber)
   }
   
   func getBuildingAtIndex(index: Int) -> Building {
      return buildingsPersistencyManager.getBuildingAtIndex(index)
   }
   
   func getNumberOfBuildings() -> Int {
      return buildingsPersistencyManager.getNumberOfBuildings()
   }
}
