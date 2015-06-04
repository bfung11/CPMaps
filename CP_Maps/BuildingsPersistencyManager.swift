//
//  BuildingPersistencyManager.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/23/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class BuildingsPersistencyManager: NSObject {
   private var buildings: [Building]
   
   override init() {
      buildings = [Building]()
      super.init()
      self.loadDataFromCSV() // what if app goes to sleep and need to reload? maybe not private then?
   }
   
   func addBuilding(building: Building) {
      buildings.append(building)
   }
   
   func getBuilding(buildingNumber: String) -> Building {
      return buildings[calculateIndex(buildingNumber)]
   }
   
   func getBuildingAtIndex(indexPath: NSIndexPath) -> Building {
      return buildings[indexPath.row]
   }
   
   func getNumberOfBuildings() -> Int {
      return buildings.count
   }
   
   func getAllBuildings() -> [Building] {
      return buildings
   }
   
   private func calculateIndex(buildingNumber: String) -> Int {
      var index = 0
      var hasIndex = false
      
      for (index = 0; index < buildings.count && hasIndex == false; ++index) {
         if buildings[index].getNumber() == buildingNumber {
            hasIndex = true
         }
      }
      
      return index - 1 // because index incremented after conditional
   }
   
   private func loadDataFromCSV() {
      var buildingsDataParsed = [Building]()
      
      let path = NSBundle.mainBundle().pathForResource("Building_Info", ofType: "csv")
      
      if let aStreamReader = StreamReader(path: path!) { // Read comments above
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
         buildings = buildingsDataParsed
      }
   }
}
