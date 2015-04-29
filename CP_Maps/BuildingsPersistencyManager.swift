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
      buildings = buildingsData as! [Building]
   }
   
   func addBuilding(building: Building) {
      buildings.append(building)
   }
   
   func getBuildingName(index: Int) -> String {
      return buildings[index].name
   }
   
   func getBuildingNumber(index: Int) -> String {
      return buildings[index].number
   }
   
   func getNumberOfBuildings() -> Int {
      return buildings.count
   }
   
   func getLongitude(index: Int) -> Double {
      return buildings[index].longitude
   }
   
   func getLatitude(index: Int) -> Double {
      return buildings[index].latitude
   }
}
