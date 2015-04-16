//
//  LocationLibraryAPI.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

// API that all classes uses to interface with locations
// should create all objects before passing to persistencyManager
// (i.e. get location or get string and create location before passing to persistencyManager)
class LocationLibraryAPI: NSObject {
   private let persistencyManager: PersistencyManager
   
   static let sharedInstance = LocationLibraryAPI()
   
   override init() {
      persistencyManager = PersistencyManager()
      
      super.init()
   }
   
//   func addLocation(location: Location) {
//      persistencyManager.addLocation(location)
//   }
//   
//   func getLocation(index: Int) -> Location {
//      
//   }
}
