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
   
   //exclamation point - does not instantiate, but must do so before use
   var location: Location!
   var buildings: [Building]! //holds the data for all buildings
   var selectedBuilding: Building! //building from choosing a builidng or from editing a location
   var selectedRoom: Room? //room from choosing a room or from editing a location with room
   var courseTitle: String?
   var selectedDays: [Day]!
   var startTime: String?
   var endTime: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      buildings = buildingsData
      selectedDays = [Day]()
      
      if location != nil { //if not from editLocation
         selectedBuilding = location.building
         buildingDetail.text = "Building " + selectedBuilding.number + " (" + selectedBuilding.name + ")"
         
         selectedRoom = location.room
         if selectedRoom != nil {
            roomDetail.text = "Room " + selectedRoom!.number
         }
         if location.course != nil {
            courseTitleTextField.text = location.course!.name
            courseTitle = location.course!.name
         }
         
         self.selectedDays = location!.course!.days
         if !selectedDays.isEmpty {
            daysDetail.text = self.getCourseDays()
         }
         self.navigationItem.title = editLocationViewControllerTitle
      }
      else {
         self.navigationItem.title = addLocationViewControllerTitle
      }
      
      if selectedBuilding == nil {
         //disable room selection if building not selected
         chooseRoomCell.userInteractionEnabled = false;
         chooseRoomCell.textLabel!.textColor = UIColor.grayColor();
      }
      
      //initialize date pickers
      startTimeDatePicker.addTarget(self, action: Selector("changeStartDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
      endTimeDatePicker.addTarget(self, action: Selector("changeEndDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
   }
   
   @IBAction func cancelAddEditLocationDetails(segue:UIStoryboardSegue) {
   }
   
   //save building details and update building details to reflect selection
   @IBAction func saveBuilding(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as ChooseBuildingRoomViewController
      selectedBuilding = viewController.selectedItem! as Building
      buildingDetail.text = "Building " + selectedBuilding.number + " (" + selectedBuilding.name + ")"
      
      roomDetail.text = "None"
      selectedRoom = nil
      
      //enable room selection
      chooseRoomCell.userInteractionEnabled = true;
      chooseRoomCell.textLabel!.textColor = UIColor.blackColor();
   }
   
   //save room details and update room details to reflect selection
   @IBAction func saveRoom(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as ChooseBuildingRoomViewController
      selectedRoom = viewController.selectedItem! as Room
      roomDetail.text = "Room " + selectedRoom!.number
   }
   
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      let chooseDaysViewController = segue.sourceViewController as ChooseDaysViewController
      //set as or as empty array
      selectedDays = chooseDaysViewController.selectedDays
      if selectedDays.isEmpty {
         daysDetail.text = ""
      }
      else {
         daysDetail.text = self.getCourseDays()
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
         let viewController = segue.destinationViewController as ChooseBuildingRoomViewController
         viewController.identifier = chooseBuildingSegueIdentifier
         viewController.data = buildingsData
         viewController.selectedItem = selectedBuilding
      }
      if segue.identifier == chooseRoomSegueIdentifier {
         let viewController = segue.destinationViewController as ChooseBuildingRoomViewController
         viewController.identifier = chooseRoomSegueIdentifier
         viewController.data = selectedBuilding!.rooms
         viewController.selectedItem = selectedRoom
      }
      if segue.identifier == chooseDaysSegueIdentifier {
         let viewController = segue.destinationViewController as ChooseDaysViewController
         viewController.selectedDays = selectedDays
      }
      if segue.identifier == saveLocationSegueIdentifer {
         var courseTitle = self.courseTitleTextField.text
         
         if location != nil { //for some reason, replacing the old location with a new location does not work
            location.building = selectedBuilding
            location.room = selectedRoom
            location.course = Course(name: courseTitle?, selectedDays: selectedDays, startTime: startTime?, endTime: endTime?)
         }
         else {
            location = Location(building: selectedBuilding!, room: selectedRoom,
               course: Course(name: courseTitle?, selectedDays: selectedDays, startTime: startTime?, endTime: endTime?))
         }
      }
   }
   
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         courseTitleTextField.becomeFirstResponder()
      }
   }
   
   private func getCourseDays() -> NSString {
      var tempTitle = ""
      var finalTitle: NSString!
      
      for day in selectedDays {
         tempTitle += day.name + ", "
      }
      
      finalTitle = NSString(string: tempTitle)
      finalTitle = finalTitle.substringToIndex(finalTitle.length - 2)
      
      return finalTitle
   }
}
