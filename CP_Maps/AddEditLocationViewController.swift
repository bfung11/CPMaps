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
   
   var location: Location! //exclamation point - does not instantiate, but must do so before use
   var buildings = buildingsData
   var building: Building!
   var room: Room?
   var courseTitle: String?
   var days = [String]()
   var startTime: String?
   var endTime: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if location != nil { //if not from editLocation
         building = location.building
         buildingDetail.text = "Building " + building.number + " (" + building.name + ")"
         
         room = location.room
         if room != nil {
            roomDetail.text = "Room " + room!.number
         }
      }
      
      if building == nil {
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
      building = viewController.selectedItem! as Building
      buildingDetail.text = "Building " + building.number + " (" + building.name + ")"
      
      roomDetail.text = "None"
      room = nil
      
      //enable room selection
      chooseRoomCell.userInteractionEnabled = true;
      chooseRoomCell.textLabel!.textColor = UIColor.blackColor();
   }
   
   //save room details and update room details to reflect selection
   @IBAction func saveRoom(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as ChooseBuildingRoomViewController
      room = viewController.selectedItem! as Room
      roomDetail.text = "Room " + room!.number
   }
   
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      var daysTitle = ""
      var day: String

      let chooseDaysViewController = segue.sourceViewController as ChooseDaysViewController
      //set as or as empty array
      days = chooseDaysViewController.selectedDays
      if days.isEmpty {
         days = [String]()
      }
      //add days into title
      for day in days {
         daysTitle += ", " + day;
      }
      //update days detail to reflect selection(s)
      daysDetail.text = daysTitle.substringFromIndex(advance(daysTitle.startIndex, 2))
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
      
      if identifier == saveLocationSegueIdentifer && building == nil { //if they have not selected a building
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
         viewController.selectedItem = building
      }
      if segue.identifier == chooseRoomSegueIdentifier {
         let viewController = segue.destinationViewController as ChooseBuildingRoomViewController
         viewController.identifier = chooseRoomSegueIdentifier
         viewController.data = building!.rooms
         viewController.selectedItem = building
      }
      if segue.identifier == saveLocationSegueIdentifer {
         var courseTitle = self.courseTitleTextField.text
         
         if courseTitle == nil {
            courseTitle = ""
         }
         if startTime == nil {
            startTime = ""
         }
         if endTime == nil {
            endTime = ""
         }
         
         location = Location(building: building!, room: room,
            course: Course(name: courseTitle!, daysAsString: days, startTime: startTime!, endTime: endTime!))
      }
   }
   
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         courseTitleTextField.becomeFirstResponder()
      }
   }
}
