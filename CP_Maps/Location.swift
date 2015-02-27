//
//  Location.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Location: NSObject {
   var building : Building
   var room: Room
   var course: Course
   
   init(building: Building, room: Room, course: Course) {
      self.building = building
      self.room = room
      self.course = course
   }
   
   func getCourseDetails() -> String{
      var timesTitle = " " + course.startTime + " - " + course.endTime
      var courseTitle = course.name + " "
      
      if course.name == "" {
         courseTitle = ""
      }
      if course.startTime == "" || course.endTime == "" {
         timesTitle = ""
      }
      return courseTitle + course.getShortHandDays() + timesTitle
   }
}
