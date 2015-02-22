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
   var course : Course
   
   init(buildingName: String, buildingNumber: String, roomNumber: String,
      courseTitle: String, daysAsString: [String], startTime: String, endTime: String){
         
         self.building = Building(name: buildingName, number: buildingNumber, room: roomNumber)
         self.course = Course(name: courseTitle, daysAsString: daysAsString,
            startTime: startTime, endTime: endTime)
   }
   
   //Optimization: Already created an object before this -> perhaps don't need to recreate it
   init(building: Building, course: Course) {
      self.building = Building(building: building) //could just change to reference to all one building and diff rooms...
      self.course = Course(course: course)
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
