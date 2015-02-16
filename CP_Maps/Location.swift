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
         if day == "Sunday" {
            self.classDays += "Su"
         }
         else if day == "Monday" {
            self.classDays += "M"
         }
         else if day == "Tuesday" {
            self.classDays += "Tu"
         }
         else if day == "Wednesday" {
            self.classDays += "W"
         }
         else if day == "Thursday" {
            self.classDays += "Th"
         }
         else if day == "Friday" {
            self.classDays += "F"
         }
         else if day == "Saturday" {
            self.classDays += "Sa"
         }
      }
   }
   
   func getClassDetails() -> String{
      self.shorthandDays()
      return self.className + " " + self.classDays + " " + self.classTimes
   }
}
