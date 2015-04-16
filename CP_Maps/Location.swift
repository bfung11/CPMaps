//
//  Location.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Location: NSObject {
   var building: Building!
   var room: Room?
   var course: Course?
   
   init(building: Building, room: Room?, course: Course?) {
      self.building = building
      self.room = room
      self.course = course
   }
   
   //Put in Course.swift?
   func getCourseDetails() -> String {
      return course!.getCourseDetails()
   }
   
   func updateBuilding(building: Building) {
      self.building = building
      self.room = nil
   }
   
   func updateRoom(room: Room) {
      self.room = room
   }
   
   func updateCourse() {
      
   }
}
