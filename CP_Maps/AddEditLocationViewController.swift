//
//  AddEditLocationViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class AddEditLocationViewController: UITableViewController {
   @IBOutlet weak var buildingDetail: UILabel!
   @IBOutlet weak var chooseRoomCell: UITableViewCell!
   @IBOutlet weak var roomTextField: UITextField!
   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var daysDetail: UILabel!
   @IBOutlet weak var startTimeLabel: UILabel!
   @IBOutlet weak var startTimeDatePicker: UIDatePicker!
   @IBOutlet weak var endTimeLabel: UILabel!
   @IBOutlet weak var endTimeDatePicker: UIDatePicker!
   
   // exclamation point - does not instantiate, but must do so before use
   var selectedLocation: NSIndexPath!  // location passed as index
   var locations: CPMapsLibraryAPI!    // location as sharedInstance
   var buildings: [Building]!          // holds the data for all buildings
   var buildingIndexPath: NSIndexPath! // selected building as index (of the list of all buildings)
   var selectedRoom: String?           // room from choosing a room or from editing a location with room
   var name: String?
   var selectedDays: String?
   var selectedDaysAsArray: [Day]?
   var startTime: String?
   var endTime: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // set up data source
      locations = CPMapsLibraryAPI.sharedInstance
      buildingIndexPath = nil
      
      if selectedLocation != nil { // if editing a location, then location must always be passed
         buildingDetail.text = "Building " + locations.getLocationBuildingNumber(selectedLocation.row) + " (" +
            locations.getLocationBuildingName(selectedLocation.row) + ")"
         if locations.locationHasRoom(selectedLocation.row) {
            roomTextField.text = "Room " + locations.getLocationRoom(selectedLocation.row)!
            selectedRoom = locations.getLocationRoom(selectedLocation.row)
         }
         if locations.locationHasName(selectedLocation.row) {
            nameTextField.text = locations.getLocationName(selectedLocation.row)
         }
         self.selectedDays = locations.getLocationDays(selectedLocation.row)
         if locations.locationHasDays(selectedLocation.row) {
            daysDetail.text = self.getCourseDays() as! String
         }
         self.navigationItem.title = editLocationViewControllerTitle
      }
      else {
         // disable room selection if building not selected
         chooseRoomCell.userInteractionEnabled = false;
         chooseRoomCell.textLabel!.textColor = UIColor.grayColor();
         
         self.navigationItem.title = addLocationViewControllerTitle
      }
      
      // initialize date pickers
      startTimeDatePicker.addTarget(self,
         action: Selector("changeStartDatePicker:"),
         forControlEvents: UIControlEvents.ValueChanged)
      endTimeDatePicker.addTarget(self,
         action: Selector("changeEndDatePicker:"),
         forControlEvents: UIControlEvents.ValueChanged)
   }
   
   @IBAction func cancelAddEditLocationDetails(segue:UIStoryboardSegue) {
   }
   
   // save selected building and display selected building
   @IBAction func saveBuilding(segue:UIStoryboardSegue) {
      
      // save building and display selected building
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      buildingIndexPath = viewController.buildingIndexPath
      buildingDetail.text = "Building " + locations.getBuildingNumber(buildingIndexPath.row) + " (" + locations.getBuildingName(buildingIndexPath.row) + ")"
   }
   
   // save selected days and display selected days
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      // get selected days from view controller
      let chooseDaysViewController = segue.sourceViewController as! ChooseDaysViewController
      let selectedDaysAsArray = chooseDaysViewController.selectedDays // can be empty, not nil
//      selectedDays = chooseDaysViewController.selectedDays // can be empty, not nil
      
      // display selected days
      daysDetail.text = "None"
      if !selectedDaysAsArray!.isEmpty {
         daysDetail.text = self.getCourseDays() as String
      }
   }
   
   //redundant code
   func changeStartDatePicker(datePicker:UIDatePicker) {
      var dateFormatter = NSDateFormatter()
      
      //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
      //save time
      dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
      startTime = dateFormatter.stringFromDate(startTimeDatePicker.date)
      
      //display date and time
      dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
      startTimeLabel.text = dateFormatter.stringFromDate(startTimeDatePicker.date)
   }
   //redundant code
   func changeEndDatePicker(datePicker:UIDatePicker) {
      var dateFormatter = NSDateFormatter()
      
      //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
      dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
      endTimeLabel.text = dateFormatter.stringFromDate(endTimeDatePicker.date)
   }
   
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
      var shouldPerform = true
      
      if identifier == saveLocationSegueIdentifer && buildingIndexPath == nil { //if they have not selected a building
         let alert =
         UIAlertView(title: saveNewLocationTitle, message: saveNewLocationMessage, delegate: self, cancelButtonTitle: cancelButtonTitleOK)
         alert.show()
         shouldPerform = false
      }
      
      return shouldPerform
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == chooseBuildingSegueIdentifier {
         let viewController = segue.destinationViewController as! ChooseBuildingRoomViewController
         viewController.identifier = chooseBuildingSegueIdentifier
         viewController.buildingIndexPath = buildingIndexPath
      }
      if segue.identifier == chooseDaysSegueIdentifier {
         let viewController = segue.destinationViewController as! ChooseDaysViewController
         viewController.selectedDays = selectedDaysAsArray
      }
      if segue.identifier == saveLocationSegueIdentifer {
         if selectedLocation != nil { // if from editing
            // TODO: update building
            locations.updateLocationRoomNumber(index: selectedLocation.row, roomNumber: selectedRoom!)
         }
         else {
            locations.addLocation(self.nameTextField.text, buildingNumber: locations.getBuildingNumber(buildingIndexPath.row), roomNumber: selectedRoom, startTime: startTime, endTime: endTime, days: selectedDays) // name is "blank space"
            // TODO: add location
         }
      }
   }
   
   /*! Takes all the selected days, puts them into a string separated by commas 
       and returns it. Used to display the selected days when adding or editing location
   
   */
   private func getCourseDays() -> NSString {
      var tempTitle = ""
      var finalTitle: NSString!
      
      // add all the days separated by commas
      for day in selectedDaysAsArray! {
         tempTitle += day.name + ", "
      }
      
      // delete the final comma added to the string
      finalTitle = NSString(string: tempTitle)
      finalTitle = finalTitle.substringToIndex(finalTitle.length - numCharactersToRemoveForFinalLengthOfSelectedDaysString)
      
      return finalTitle
   }
}
