//
//  Day.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/16/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Day: NSObject {
   var name: String
   var value: Int
   
   enum DaysOfTheWeek: Int {
      case NoDay = 0, Sunday, Monday, Tuesday, Wednesday,
      Thursday, Friday, Saturday
   }
   
   init(name: String) {
      self.name = name
      self.value = DaysOfTheWeek.NoDay.rawValue //may not need
      super.init()
      self.value = self.attachValueToDay(name)
   }
   
   init(name: String, value: Int) {
      self.name = name
      self.value = value
      super.init()
   }
   
   private func attachValueToDay(name: String) -> Int {
      var value: Int
      
      value = 0
      switch name {
      case "Sunday":
         value = DaysOfTheWeek.Sunday.rawValue
      case "Monday":
         value = DaysOfTheWeek.Monday.rawValue
      case "Tuesday":
         value = DaysOfTheWeek.Tuesday.rawValue
      case "Wednesday":
         value = DaysOfTheWeek.Wednesday.rawValue
      case "Thursday":
         value = DaysOfTheWeek.Thursday.rawValue
      case "Friday":
         value = DaysOfTheWeek.Friday.rawValue
      case "Saturday":
         value = DaysOfTheWeek.Saturday.rawValue
      default: ()
      }
      
      return value
   }
   
   func shorthand() -> String {
      var dayAsString: String
      
      switch name {
      case "Sunday":
         dayAsString = "Su"
      case "Monday":
         dayAsString = "M"
      case "Tuesday":
         dayAsString = "Tu"
      case "Wednesday":
         dayAsString = "W"
      case "Thursday":
         dayAsString = "Th"
      case "Friday":
         dayAsString = "F"
      case "Saturday":
         dayAsString = "Sa"
      default:
         dayAsString = ""
      }
      
      return dayAsString
   }
}