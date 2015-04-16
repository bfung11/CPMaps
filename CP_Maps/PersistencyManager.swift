//
//  PersistencyManager.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

// manager that controls all persistent objects
// should only have the add proper object into list (i.e. add Location to location array)
// not create location object from string then add
class PersistencyManager: NSObject {
   private var locations: [Location]
   
   override init() {
      locations = locationsData as! [Location]
   }
   
   func addLocation(location: Location) {
      locations.append(location)
   }
}
