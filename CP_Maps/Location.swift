//
//  Location.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

class Location: NSManagedObject {
   @NSManaged var name: String?
   @NSManaged var buildingNumber: String!  
   @NSManaged var roomNumber: String?
   @NSManaged var startTime: String?
   @NSManaged var endTime: String?
   @NSManaged var days: String?            // Stores the entire string with commas
   
   
   class func createInManagedObjectContext(name: String?, buildingNumber: String!, roomNumber: String?,
      startTime: String?, endTime: String?, days: String?,
      insertIntoManagedObjectContext context: NSManagedObjectContext?) {
         let location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context!) as! Location
         location.setValue(name, forKey: "name")
         location.setValue(buildingNumber, forKey: "buildingNumber")
         location.setValue(roomNumber, forKey: "roomNumber")
         location.setValue(startTime, forKey: "startTime")
         location.setValue(endTime, forKey: "endTime")
         location.setValue(days, forKey: "days")
   }
   
   func updateBuilding(buildingNumber: String) {
      self.buildingNumber = buildingNumber
      self.roomNumber = "None"
   }
   
   func updateRoom(roomNumber: String) {
      self.roomNumber = roomNumber
   }
   
   func hasName() -> Bool {
      return self.name != nil
   }
   
   func hasRoomNumber() -> Bool {
      return self.roomNumber != nil
   }
   
   func hasDays() -> Bool {
      return self.days != nil
   }
   
   func getName() -> String? {
      return self.name
   }
   
   func getBuildingNumber() -> String {
      return self.buildingNumber
   }
   
   func getRoomNumber() -> String? {
      return self.roomNumber
   }
   
   func getStartTime() -> String? {
      return self.startTime
   }
   
   func getEndTime() -> String? {
      return self.endTime
   }
   
   func getDays() -> String? {
      return self.days
   }
   
   func update(name: String?, buildingNumber: String!, roomNumber: String?,
      startTime: String?, endTime: String?, days: String?) {
         self.name = name
         self.buildingNumber = buildingNumber
         self.roomNumber = roomNumber
         self.startTime = startTime
         self.endTime = endTime
         self.days = days
   }
   
   func updateName(name: String) {
      self.name = name
   }
   
   func updateBuildingNumber(buildingNumber: String) {
      self.buildingNumber = buildingNumber
   }
   
   func updateRoomNumber(roomNumber: String) {
      self.roomNumber = roomNumber
   }
   
   func updateDays(days: String) {
      self.days = days
   }
}
