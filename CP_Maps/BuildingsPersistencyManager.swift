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
