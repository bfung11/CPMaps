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
   var classDaysList : [Day]
   var classDaysArray = [String]()
   var classDays : String
   var classTimes : String
   
   enum Days : Int {
      case Sunday = 0, Monday, Tuesday, Wednesday,
      Thursday, Friday, Saturday
   }
   
   init(buildingName: String, buildingNumber: String, roomNumber: String,
      className: String, classDaysArray: [String], classTimes: String){
         self.buildingName = buildingName
         self.buildingNumber = buildingNumber
         self.roomNumber = roomNumber
         self.className = className
         self.classDaysList = [Day]()
         self.classDaysArray = classDaysArray
         self.classDays = ""
         self.classTimes = classTimes
         super.init()
         convertStringsToDays(classDaysArray)
   }
   
   private func convertStringsToDays(arr: [String]) {
      var value : Int
      
      value = 0
      for name in arr {
         switch name {
         case "Sunday":
            value = Days.Sunday.rawValue
         case "Monday":
            value = Days.Monday.rawValue
         case "Tuesday":
            value = Days.Tuesday.rawValue
         case "Wednesday":
            value = Days.Wednesday.rawValue
         case "Thursday":
            value = Days.Thursday.rawValue
         case "Friday":
            value = Days.Friday.rawValue
         case "Saturday":
            value = Days.Saturday.rawValue
         default: ()
         }
         
         classDaysList.append(Day(name: name, value: value))
      }
   }
   
   private func shorthandDays() -> String {
      var classDaysShortHand : String
      classDaysShortHand = ""
      
      for day in self.classDaysList {
         switch day.name {
         case "Sunday":
            classDaysShortHand += "Su"
         case "Monday":
            classDaysShortHand += "M"
         case "Tuesday":
            classDaysShortHand += "Tu"
         case "Wednesday":
            classDaysShortHand += "W"
         case "Thursday":
            classDaysShortHand += "Th"
         case "Friday":
            classDaysShortHand += "F"
         case "Saturday":
            classDaysShortHand += "Sa"
         default:
            classDaysShortHand += ""
         }
      }
      
      return classDaysShortHand
   }
   
   func getClassDetails() -> String{
      return self.className + " " + self.shorthandDays() + " " + self.classTimes
   }
}
