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
   
   /*
   var buildingName : String
   var buildingNumber : String
   var roomNumber : String
   var className : String
   var classDaysList : [Day]
   var classDays : String
   var classTimes : String
   */
   
   init(buildingName: String, buildingNumber: String, roomNumber: String,
      courseTitle: String, daysAsString: [String], startTime: String, endTime: String){
         
         self.building = Building(name: buildingName, number: buildingNumber, room: roomNumber)
         self.course = Course(name: courseTitle, daysAsString: daysAsString,
            startTime: startTime, endTime: endTime)
         /*
         self.buildingName = buildingName
         self.buildingNumber = buildingNumber
         self.roomNumber = roomNumber
         self.className = className
         self.classDaysList = [Day]()
         self.classDays = ""
         self.classTimes = classTimes
         super.init()
         classDaysList = (convertStringsToDays(classDaysArray))
         classDaysList.sort({$0.value < $1.value})
         */
   }
   
   //Optimization: Already created an object before this -> perhaps don't need to recreate it
   init(building: Building, course: Course) {
      self.building = Building(building: building) //could just change to reference to all one building and diff rooms...
      self.course = Course(course: course)
   }
   
   func getCourseDetails() -> String{
      return course.name + " " + course.getShortHandDays() + " " + course.startTime + " - " + course.endTime
   }
}
