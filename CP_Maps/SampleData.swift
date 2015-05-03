//
//  SampleData.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import Foundation

var buildingsData = [
   Building(name: "Administration", number: "1",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Cotchett Education Building", number: "2",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Business", number: "3",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Research Development Center", number: "4",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Architecture & Environmental Design", number: "5",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Christopher Cohan Center", number: "6",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Advanced Technologies Labratories", number: "7",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Bioresource and Agricultural Engineering", number: "8",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Farm Shop", number: "9",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Alan A. Erhart Agriculture", number: "10",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Agricultural Sciences", number: "11",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Engineering", number: "13",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Frank E. Pilling", number: "14",
      rooms: [Room(number: "256"), Room(number: "257"), Room(number: "258")]
   ),
   Building(name: "Cal Poly Corporation Administration", number: "15",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Beef Unit", number: "16",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Crops Unit", number: "17",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Dairy Science Milking Parlor", number: "18",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Leprino Foods Dairy Innovation Institute", number: "18A",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   ),
   Building(name: "Dining Complex", number: "19",
      rooms: [Room(number: "1"), Room(number: "2"), Room(number: "3")]
   )
]

var locationsData = []

//var locationsData = [
//    Location(building: buildingsData[0], room: buildingsData[0].rooms[0],
//      course: Course(name: "CPE-101", selectedDays: ["Monday", "Wednesday", "Friday"], startTime: "8:10", endTime: "9:00")),
//   Location(building: buildingsData[1], room: buildingsData[1].rooms[0],
//      course: Course(name: "CPE-102", selectedDays: ["Monday", "Wednesday", "Friday"], startTime: "9:10", endTime: "10:00")),
//   Location(building: buildingsData[1], room: buildingsData[1].rooms[1],
//      course: Course(name: "CPE-103", selectedDays: ["Monday", "Wednesday", "Friday"], startTime: "10:10", endTime: "11:00")),
//]

var daysData = [Day(name: "Sunday"), Day(name: "Monday"), Day(name: "Tuesday") , Day(name: "Wednesday"),
   Day(name: "Thursday"), Day(name: "Friday"), Day(name: "Saturday")]
