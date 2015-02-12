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
   var buildingNum : String
   var roomNum : String
   var locationTitle : String
   var roomTitle : String
   var className : String
   var classDays : String
   var classTimes : String
   var classInfo : String
   
   init(buildingName: String, buildingNum: String, roomNum: String,
      className: String, classDays: String, classTimes: String){
      self.buildingName = buildingName
      self.buildingNum = buildingNum
      self.roomNum = roomNum
      self.locationTitle = "Building " + buildingNum + " (" + buildingName + ")"
      self.roomTitle = "Room " + roomNum
      self.className = className
      self.classDays = classDays
      self.classTimes = classTimes
      self.classInfo = className + " " + classDays + " " + classTimes
      super.init()
   }
}
