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
   @IBOutlet weak var roomDetail: UILabel!
   @IBOutlet weak var courseTitleTextField: UITextField!
   @IBOutlet weak var daysDetail: UILabel!
   @IBOutlet weak var startTimeLabel: UILabel!
   @IBOutlet weak var startTimeDatePicker: UIDatePicker!
   @IBOutlet weak var endTimeLabel: UILabel!
   @IBOutlet weak var endTimeDatePicker: UIDatePicker!
   
   // exclamation point - does not instantiate, but must do so before use
   var indexPath: NSIndexPath!
   var location: LocationLibraryAPI!
   var tempLocation: Location!
   var buildings: [Building]!      // holds the data for all buildings
   var selectedBuilding: Building! // building from choosing a builidng or from editing a location
   var selectedRoom: Room?         // room from choosing a room or from editing a location with room
   var courseName: String?
   var selectedDays: [Day]!        // list of selected days
   var startTime: String?
   var endTime: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // set up data source
      buildings = buildingsData
      selectedDays = [Day]()
      
      location = LocationLibraryAPI.sharedInstance
      
      // if editing a location location
      if tempLocation != nil { // if from editing a location, then location must always be passed
         
         // update building
         selectedBuilding = location.getBuilding(indexPath.row)
         buildingDetail.text = "Building " + selectedBuilding.number + " (" + selectedBuilding.name + ")"
         
         // update room
//         selectedRoom = location.getRoom(indexPath.row)
         if location.hasRoom(indexPath.row) { // if there is a room
            roomDetail.text = "Room " + location.getRoom(indexPath.row)!.number
         }
         
         // update course
         if tempLocation.course != nil { // if there is a course
            courseTitleTextField.text = tempLocation.course!.name
            courseName = tempLocation.course!.name
         }
         
         // update selected days
         self.selectedDays = tempLocation!.course!.days
         if !selectedDays.isEmpty { // if there are selected days
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
      startTimeDatePicker.addTarget(self, action: Selector("changeStartDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
      endTimeDatePicker.addTarget(self, action: Selector("changeEndDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
   }
   
   @IBAction func cancelAddEditLocationDetails(segue:UIStoryboardSegue) {
   }
   
   
   // save selected building and display selected building
   @IBAction func saveBuilding(segue:UIStoryboardSegue) {
      
      // save building and display selected building
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      selectedBuilding = viewController.selectedItem! as! Building
      buildingDetail.text = "Building " + selectedBuilding.number + " (" + selectedBuilding.name + ")"
      
      // if choose a new building,
      selectedRoom = nil // deselect room
      roomDetail.text = "None" // display no selected room
      
      // enable room selection
      chooseRoomCell.userInteractionEnabled = true;
      chooseRoomCell.textLabel!.textColor = UIColor.blackColor();
   }
   
   // save selected room and display selected room
   @IBAction func saveRoom(segue:UIStoryboardSegue) {
      // save room and display selected room
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      selectedRoom = viewController.selectedItem! as! Room
      roomDetail.text = "Room " + selectedRoom!.number
   }
   
   // save selected days and display selected days
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      // get selected days from view controller
      let chooseDaysViewController = segue.sourceViewController as! ChooseDaysViewController
      selectedDays = chooseDaysViewController.selectedDays // can be empty, not nil
      
      // display selected days
      daysDetail.text = "None"
      if !selectedDays.isEmpty {
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
      
      if identifier == saveLocationSegueIdentifer && selectedBuilding == nil { //if they have not selected a building
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
         viewController.data = buildingsData
         viewController.selectedItem = selectedBuilding
      }
      if segue.identifier == chooseRoomSegueIdentifier {
         let viewController = segue.destinationViewController as! ChooseBuildingRoomViewController
         viewController.identifier = chooseRoomSegueIdentifier
         viewController.data = selectedBuilding!.rooms
         viewController.selectedItem = selectedRoom
      }
      if segue.identifier == chooseDaysSegueIdentifier {
         let viewController = segue.destinationViewController as! ChooseDaysViewController
         viewController.selectedDays = selectedDays
      }
      if segue.identifier == saveLocationSegueIdentifer {
         var courseName = self.courseTitleTextField.text
         
         if tempLocation != nil { // if from editing
            // replace objects in location
            // for some reason, replacing the location does not work
            tempLocation.building = selectedBuilding
            tempLocation.room = selectedRoom
            tempLocation.course = Course(name: courseName, selectedDays: selectedDays, startTime: startTime, endTime: endTime)
         }
         else {
            tempLocation = Location(building: selectedBuilding!, room: selectedRoom,
               course: Course(name: courseName, selectedDays: selectedDays, startTime: startTime, endTime: endTime))
         }
      }
   }
   
//   //Allows user to tap anywhere in cell to bring up keyboard
//   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//      if indexPath.section == 0 {
//         courseTitleTextField.becomeFirstResponder()
//      }
//   }
   
   
   /*! Takes all the selected days, puts them into a string separated by commas 
       and returns it. Used to display the selected days when adding or editing location
   
   */
   private func getCourseDays() -> NSString {
      var tempTitle = ""
      var finalTitle: NSString!
      
      // add all the days separated by commas
      for day in selectedDays {
         tempTitle += day.name + ", "
      }
      
      // delete the final comma added to the string
      finalTitle = NSString(string: tempTitle)
      finalTitle = finalTitle.substringToIndex(finalTitle.length - numCharactersToRemoveForFinalLengthOfSelectedDaysString)
      
      return finalTitle
   }
}
