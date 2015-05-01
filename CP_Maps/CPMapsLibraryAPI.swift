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
                  floors: (buildingArr[2] as NSString).integerValue,
                  latitude: (buildingArr[3] as NSString).doubleValue,
                  longitude: (buildingArr[4] as NSString).doubleValue))
            }
         
            if buildingArr.count == 3 {
               buildingsDataParsed.append(Building(
                  number: buildingArr[0],
                  name: buildingArr[1]))
            }
         }
         aStreamReader.close()
         // set buildingsData to new data
         buildingsData = buildingsDataParsed
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
   
   func locationHasName(index: Int) -> Bool {
      return locationsPersistencyManager.hasName(index)
   }
   
   func getLocationName(index: Int) -> String {
      return locationsPersistencyManager.getName(index)
   }
   
   func updateLocationName(#index: Int, name: String) {
      locationsPersistencyManager.updateName(index: index, name: name)
   }
   
   func getBuildingAtLocation(buildingNumber: String) -> Building {
      return buildingsPersistencyManager.getBuilding(buildingNumber);
   }
   
   func getBuildingNameAtLocation(index: Int) -> String {
      return buildingsPersistencyManager.getBuildingName(index)
   }
   
   func getBuildingNumberAtLocation(index: Int) -> String {
      return locationsPersistencyManager.getBuildingNumber(index)
   }
   
   func updateBuildingNumberAtLocation(#index: Int, buildingNumber: String) {
      locationsPersistencyManager.updateBuildingNumber(index: index, buildingNumber: buildingNumber)
   }
   
   func doesLocationHaveRoom(index: Int) -> Bool {
      return locationsPersistencyManager.hasRoom(index)
   }
   
   func getRoomNumberAtLocation(index: Int) -> String {
      return locationsPersistencyManager.getRoomNumber(index)
   }
   
   func updateRoomNumberAtLocation(#index: Int, roomNumber: String) {
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
   
   func getBuilding(buildingNumber: String) -> Building {
      return buildingsPersistencyManager.getBuilding(buildingNumber)
   }
   
   func getBuildingAtIndex(index: Int) -> Building {
      return buildingsPersistencyManager.getBuildingAtIndex(index)
   }
   
   func getBuildingNumber(index: Int) -> String {
      return buildingsPersistencyManager.getBuildingNumber(index)
   }
   
   func getNumberOfBuildings() -> Int {
      return buildingsPersistencyManager.getNumberOfBuildings()
   }
   
   func getBuildingLongitude(index: Int) -> Double {
      return buildingsPersistencyManager.getLongitude(index)
   }
   
   func getBuildingLatitude(index: Int) -> Double {
      return buildingsPersistencyManager.getLatitude(index)
   }
}
