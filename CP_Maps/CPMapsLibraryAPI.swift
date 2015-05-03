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
      var buildingsDataParsed = [Building]()
      // load in buildings from CSV file -- this only works for Carl at the moment...
      if let aStreamReader = StreamReader(path: "/Users/carllindiii/Desktop/Brians CPMaps/CP_Maps/Building_Info.csv") {
         while let line = aStreamReader.nextLine() {
            var buildingArr = split(line) {$0 == ","}
            
            if buildingArr.count == 5 {
               buildingsDataParsed.append(Building(
                  number: buildingArr[0],
                  name: buildingArr[1],
                  numberOfFloors: (buildingArr[2] as NSString).integerValue,
                  latitude: (buildingArr[3] as NSString).doubleValue,
                  longitude: (buildingArr[4] as NSString).doubleValue))
            }
         
            if buildingArr.count == 2 {
               buildingsDataParsed.append(Building(
                  number: buildingArr[0],
                  name: buildingArr[1]))
            }
         }
         aStreamReader.close()
         // set buildings data
         buildingsPersistencyManager.setBuildings(buildingsDataParsed)
      }
   }
   
   func addLocation(name: String?, buildingNumber: String!, roomNumber: String?, startTime: String?, endTime: String?, days: String?) {
      locationsPersistencyManager.addLocation(name, buildingNumber: buildingNumber, roomNumber: roomNumber, startTime: startTime, endTime: endTime, days: days, context: managedObjectContext)
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
