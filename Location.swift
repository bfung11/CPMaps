//
//  Location.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Location: NSObject {
   var buildingName : String
   var buildingNumber : String
   var roomNumber : String
   var buildingTitle : String
   var roomTitle : String
   var className : String
   var classDays : String
   var classTimes : String
   var classTitle : String
   
   init(buildingName: String, buildingNumber: String, roomNumber: String,
      className: String, classDays: String, classTimes: String){
      self.buildingName = buildingName
      self.buildingNumber = buildingNumber
      self.roomNumber = roomNumber
      self.buildingTitle = "Building " + buildingNumber + " (" + buildingName + ")"
      self.roomTitle = "Room " + roomNumber
      self.className = className
      self.classDays = classDays
      self.classTimes = classTimes
      self.classTitle = className + " " + classDays + " " + classTimes
      super.init()
   }
}
