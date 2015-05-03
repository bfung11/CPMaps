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
//      buildings = buildingsData as [Building]
   }
   
   func loadDataFromCSV() {
      var buildingsDataParsed = [Building]()
      // TODO Carl: NSURL?
      // Carl, brianPath is a const so that I don't have to rewrite the path everytime
      // there is one called carlPath that is yours
      // we'll just have to deal with it until we get a relative path working
      // Can you also check out NSURL? It may have what we need. I only looked at it 
      // for a moment
      // load in buildings from CSV file -- this only works for Carl at the moment...
      if let aStreamReader = StreamReader(path: brianPath) { // Read comments above 
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
   
   func setBuildings(newBuildings: [Building]) {
      buildings = newBuildings
   }
   
   func addBuilding(building: Building) {
      buildings.append(building)
   }
   
   func getBuilding(buildingNumber: String) -> Building {
      return buildings[calculateIndex(buildingNumber)]
   }
   
   func getBuildingAtIndex(index: Int) -> Building {
      return buildings[index]
   }
   
   func getNumberOfBuildings() -> Int {
      return buildings.count
   }
   
   private func calculateIndex(buildingNumber: String) -> Int {
      var index = 0
      var hasIndex = false
      
      for (index = 0; index < buildings.count || hasIndex == false; ++index) {
         if buildings[index].getNumber() == buildingNumber {
            hasIndex = true
         }
      }
      
      return index
   }
}
