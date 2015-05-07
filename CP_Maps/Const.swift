//
//  Const.swift
//  CP_Maps
//
//  Created by Brian Fung on 3/17/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

// Paths
//let carlPath = "/Users/carllindiii/Desktop/Brians CPMaps/CP_Maps/Building_Info.csv"
//let brianPath = "/Users/brianfung/Downloads/16_Spring2015/SeniorProject/CPMaps/CP_Maps/Building_Info.csv"

let dayEnumStartValue = -1
let selectedDaysAsBoolInitialCount = 7
let selectedDaysAsBoolIntialValue = false

// Cell Reuse Identifiers
let locationCellReuseIdentifier = "LocationCell"

// View Controller Titles
let editLocationViewControllerTitle = "Edit Location"
let addLocationViewControllerTitle = "Add Location"
let chooseBuildingViewControllerTitle = "Building"
let chooseRoomViewControllerTitle = "Room"

// Number of Sections in view controllers
let numberOfSectionsInChooseBuildingRoomViewController = 1
let numberOfSectionsInDaysViewController = 1

// Segue Identifiers
let chooseBuildingForMapViewController = "finishedChoosingBuilding"
let chooseLocationSegueIdentifier = "chooseLocation"
let editLocationSegueIdentifier = "editLocation"
let saveLocationSegueIdentifer = "saveLocation"
let segueToChooseBuildingViewController = "segueToChooseBuildingViewController"
let chooseBuildingForAddEditViewController = "saveBuilding"
let chooseRoomSegueIdentifier = "chooseRoom"
let saveRoomSegueIdentifer = "saveRoom"
let findBuildingSegueIdentifer = "findBuilding"
let segueToChooseDaysViewController = "chooseDaysSegueIdentifier"

// UIAlertView Messages
let saveNewLocationTitle = "No Building Selected"
let saveNewLocationMessage = "Please select a building to create a new location"

// UIAlertView "Cancel" button titles
let cancelButtonTitleOK = "OK"

let numCharactersToRemoveForFinalLengthOfSelectedDaysString = 2

