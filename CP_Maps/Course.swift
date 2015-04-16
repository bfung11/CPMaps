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
   
   init(name: String?, selectedDays: [Day]?, startTime: String?, endTime: String?) {
      self.days = selectedDays
      super.init()
      self.initWithoutDays(name, startTime: startTime, endTime: endTime)
   }
   
   init(name: String, selectedDaysAsString: [String]?, startTime: String?, endTime: String?) {
      self.days = [Day]()
      super.init()
      self.initWithoutDays(name, startTime: startTime, endTime: endTime)
      for dayName in selectedDaysAsString! {
         self.days!.append(Day(name: dayName))
      }
   }
   
   init(course: Course) {
      self.name = course.name
      self.days = course.days
      self.startTime = course.startTime
      self.endTime = course.endTime
      super.init()
   }
   
   func initWithoutDays(name: String?, startTime: String?, endTime: String?) {
      self.name = name
      self.startTime = startTime
      self.endTime = endTime
      
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
