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
   Building(name: "Frank E. Pilling", number: "14",
      rooms: [Room(number: "256"), Room(number: "257"), Room(number: "258")]
   )
]

var locationsData = [
    Location(building: buildingsData[0], room: buildingsData[0].rooms[0],
      course: Course(name: "CPE-101", daysAsString: ["Monday", "Wednesday", "Friday"], startTime: "8:10", endTime: "9:00")),
   Location(building: buildingsData[1], room: buildingsData[1].rooms[0],
      course: Course(name: "CPE-102", daysAsString: ["Monday", "Wednesday", "Friday"], startTime: "9:10", endTime: "10:00")),
   Location(building: buildingsData[1], room: buildingsData[1].rooms[1],
      course: Course(name: "CPE-103", daysAsString: ["Monday", "Wednesday", "Friday"], startTime: "10:10", endTime: "11:00")),
]

var daysData = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
