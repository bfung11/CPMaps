//
//  Day.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/16/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Day: NSObject {
   var name: String!
   var value: Int!
   var shorthand: String!
   
   enum DaysOfTheWeek: Int {
      case NoDay = -1, Sunday, Monday, Tuesday, Wednesday,
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
      
      value = dayEnumStartValue
      switch name {
      case "Sunday":
         value = DaysOfTheWeek.Sunday.rawValue
         shorthand = "Su"
      case "Monday":
         value = DaysOfTheWeek.Monday.rawValue
         shorthand = "M"
      case "Tuesday":
         value = DaysOfTheWeek.Tuesday.rawValue
         shorthand = "Tu"
      case "Wednesday":
         value = DaysOfTheWeek.Wednesday.rawValue
         shorthand = "W"
      case "Thursday":
         value = DaysOfTheWeek.Thursday.rawValue
         shorthand = "Th"
      case "Friday":
         value = DaysOfTheWeek.Friday.rawValue
         shorthand = "F"
      case "Saturday":
         value = DaysOfTheWeek.Saturday.rawValue
         shorthand = "Sa"
      default: ()
      }
      
      return value
   }
}