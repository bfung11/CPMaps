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
   var className : String
   var classDaysArray = [String]()
   var classDays : String
   var classTimes : String
   
   init(buildingName: String, buildingNumber: String, roomNumber: String,
      className: String, classDaysArray: [String], classTimes: String){
         self.buildingName = buildingName
         self.buildingNumber = buildingNumber
         self.roomNumber = roomNumber
         self.className = className
         self.classDaysArray = classDaysArray
         self.classDays = ""
         self.classTimes = classTimes
         super.init()
   }
   
   private func shorthandDays() {
      for day in self.classDaysArray {
         switch day {
         case "Sunday":
            self.classDays += "Su"
         case "Monday":
            self.classDays += "M"
         case "Tuesday":
            self.classDays += "Tu"
         case "Wednesday":
            self.classDays += "W"
         case "Thursday":
            self.classDays += "Th"
         case "Friday":
            self.classDays += "F"
         case "Saturday":
            self.classDays += "Sa"
         default:
            self.classDays += ""
         }
      }
   }
   
   func getClassDetails() -> String{
      self.shorthandDays()
      return self.className + " " + self.classDays + " " + self.classTimes
   }
}
