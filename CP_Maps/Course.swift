//
//  Course.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/21/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Course: NSObject {
   var name: String!
   var days: [Day]!
   var startTime: String!
   var endTime: String!
   
   init(name: String?, daysAsString: [String]?, startTime: String?, endTime: String?) {
      var dayName: String
      
      self.name = name
      self.days = [Day]()
      self.startTime = startTime
      self.endTime = endTime
      super.init()
      for dayName in daysAsString! {
         self.days!.append(Day(name: dayName))
      }
      if self.name == nil {
         self.name = ""
      }
      if self.startTime == nil {
         self.startTime = ""
      }
      if self.endTime == nil {
         self.endTime = ""
      }
   }
   
   init(course: Course) {
      self.name = course.name
      self.days = course.days
      self.startTime = course.startTime
      self.endTime = course.endTime
      super.init()
   }
   
   func getShortHandDays() -> String {
      var day: Day
      var daysAsString = ""
      
      for day in days! {
         daysAsString += day.shorthand
      }
      
      return daysAsString
   }
   
   func getCourseDetails() -> String! {
      var courseTimes: String!
      
      if self.startTime == "" || self.endTime == "" {
         courseTimes = self.startTime + endTime
      }
      else {
         courseTimes = self.startTime + " - " + self.endTime
      }
      
      return self.name +  " " + self.getShortHandDays() + " " + courseTimes
   }
}
