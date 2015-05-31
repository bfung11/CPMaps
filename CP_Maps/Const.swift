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

/* ---- MainViewController Storyboard ---- */
// Segues for ChooseBuildingVC
let segueToChooseBuildingVCFromMainVC = "segueToChooseBuildingFromMainViewController"
let cancelToMainViewController = "cancelToMainViewController"
let chooseBuildingForMapViewController = "chooseBuildingForMapViewController"

// Segues for MapViewController
let showSelectedBuilding = "showSelectedBuilding"


// Saved Locations Storyboard
let savedLocationsStoryboard = "SavedLocations"
let savedLocationsTVCStoryboardID = "savedLocationsTableViewController"
let chooseRoomBuildingVCStoryboardID = "chooseRoomBuildingViewController"


let standardNavigationBarHeight: CGFloat = 74
let standardUISegmentedControlWidth: CGFloat = 110

let dayEnumStartValue = -1
let selectedDaysAsBoolInitialCount = 7
let selectedDaysAsBoolIntialValue = false

// Cell Reuse Identifiers
let locationCellReuseIdentifier = "LocationCell"
let mapTypeCellReuseIdentifier = "MapTypeCell"

// View Controller Titles
let editLocationViewControllerTitle = "Edit Location"
let addLocationViewControllerTitle = "Add Location"
let chooseBuildingViewControllerTitle = "Building"
let chooseRoomViewControllerTitle = "Room"
let choooseMapTypeTableViewControllerTitle = "Map Type"

// Tags for UIViews
let mapViewTag = 100
let locationsTableViewTag = 101

// Sections with UIDatePickers
let sectionWithUIDatePickers = 2
let startTimeDatePickerTag = 0
let endTimeDatePickerTag = 1
let indexOfDaysCell = 4

// Number of Sections in view controllers
let numberOfSectionsInChooseBuildingRoomViewController = 1
let numberOfSectionsInDaysViewController = 1

// Segue Identifiers
let segueToChooseBuildingFromMapViewController = "segueToChooseBuildingFromMapViewController"
let chooseLocationSegueIdentifier = "chooseLocation"
let editLocationSegueIdentifier = "editLocation"
let saveLocationSegueIdentifer = "saveLocation"
let segueToChooseBuildingFromAddEditLocationViewController = "chooseBuildingForAddEditLocationViewController"
let chooseRoomSegueIdentifier = "chooseRoom"
let saveRoomSegueIdentifer = "saveRoom"
let findBuildingSegueIdentifer = "findBuilding"

let chooseMapType = "chooseMapType"

let segueToChooseBuildingViewController = "segueToChooseBuildingViewController"
let segueToChooseDaysViewController = "segueToChooseDaysViewController"
let segueToFloorPlanPagedScrollViewController = "floorPlanPagedScrollViewController"
let cancelToMapViewController = "cancelToMapViewController"
let cancelToAddEditLocationViewController = "cancelToAddEditLocationViewController"

// UIAlertView Messages
let saveNewLocationTitle = "No Building Selected"
let saveNewLocationMessage = "Please select a building to create a new location"

// UIAlertView "Cancel" button titles
let cancelButtonTitleOK = "OK"

let numCharactersToRemoveForFinalLengthOfSelectedDaysString = 2

