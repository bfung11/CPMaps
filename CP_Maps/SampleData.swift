//
//  SampleData.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import Foundation

var locationsData = [
    Location(buildingName:"Frank E. Pilling", buildingNumber:"14", roomNumber:"256",
      courseName: "CPE-102", daysAsString: ["Monday", "Wednesday", "Friday"], courseTimes: "9:10 - 9:20"),
    Location(buildingName:"Fischer Science", buildingNumber:"14", roomNumber:"258",
      courseName: "CPE-102", daysAsString: ["Monday", "Wednesday", "Friday"], courseTimes: "9:10 - 9:20"),
    Location(buildingName:"Frank E. Pilling", buildingNumber:"14", roomNumber:"251",
      courseName: "CPE-102", daysAsString: ["Monday", "Wednesday", "Friday"], courseTimes: "9:10 - 9:20")]

var buildingsData = [
   Building(name: "Administration", number: "1", room: "No room"),
   Building(name: "Frank E. Pilling", number: "14", room: "No room")
]
var roomsData = ["251", "252", "253", "254", "255", "256"]
var daysData = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
