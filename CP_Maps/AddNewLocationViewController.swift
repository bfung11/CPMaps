//
//  AddNewLocationViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class AddNewLocationViewController: UITableViewController {
   @IBOutlet weak var buildingDetail: UILabel!
   @IBOutlet weak var chooseRoomCell: UITableViewCell!
   @IBOutlet weak var roomDetail: UILabel!
   @IBOutlet weak var courseTitleTextField: UITextField!
   @IBOutlet weak var daysDetail: UILabel!
   @IBOutlet weak var startTextField: UITextField!
   @IBOutlet weak var startDatePicker: UIDatePicker!
   @IBOutlet weak var endTextField: UITextField!
   @IBOutlet weak var endDatePicker: UIDatePicker!
   
   var location: Location! //exclamation point - does not instantiate, but must do so before use
   var buildings = buildingsData
   var building: Building!
   var room: Room? = nil
   var courseTitle: String!
   var days = [String]()
   var startTime: String!
   var endTime: String!
   
   @IBAction func cancelAddDetails(segue:UIStoryboardSegue) {
   }
   
   @IBAction func saveNewLocationDetails(segue:UIStoryboardSegue) {
      var labels = [String]()
      var daysTitle = ""
      var day : String
      
      switch segue.identifier! {
         case "saveBuilding":
            //save building details and update building details to reflect selection
            let chooseBuildingViewController = segue.sourceViewController as ChooseBuildingViewController
            building = chooseBuildingViewController.selectedBuilding
            buildingDetail.text = "Building " + building.number + " (" + building.name + ")"
            //enable room selection
            chooseRoomCell.userInteractionEnabled = true;
            chooseRoomCell.textLabel!.textColor = UIColor.blackColor();
         case "saveRoom":
            //save room details and update room details to reflect selection
            let chooseRoomViewController = segue.sourceViewController as ChooseRoomViewController
            room = chooseRoomViewController.selectedRoom
            roomDetail.text = "Room " + room!.number
         case "saveDays":
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
         default: ()
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //disable room selection if building not selected
      chooseRoomCell.userInteractionEnabled = false;
      chooseRoomCell.textLabel!.textColor = UIColor.grayColor();
      
      //initialize date pickers
      startDatePicker.addTarget(self, action: Selector("changeStartDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
      endDatePicker.addTarget(self, action: Selector("changeEndDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
   }
   
   //redundant code
   func changeStartDatePicker(datePicker:UIDatePicker) {
      var dateFormatter = NSDateFormatter()
      
      //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
      //save time
      dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
      startTime = dateFormatter.stringFromDate(startDatePicker.date)
      
      //display date and time
      dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
      startTextField.text = dateFormatter.stringFromDate(startDatePicker.date)
   }
   //redundant code
   func changeEndDatePicker(datePicker:UIDatePicker) {
      var dateFormatter = NSDateFormatter()
      
      //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
      dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
      endTime = dateFormatter.stringFromDate(endDatePicker.date)
      endTextField.text = endTime
   }
   
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
      var shouldPerform = true
      
      if identifier == "saveNewLocation" {
         if building == nil {
            let alert =
            UIAlertView(title: "No Building Selected", message: "Please select a building to create a new location", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            shouldPerform = false
         }
         else {
            performSegueWithIdentifier("saveNewLocation", sender: self)
         }
      }
      
      return shouldPerform
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "segueToChooseRoomViewController" {
         //save selected building to choose rooms
         let chooseRoomViewController = segue.destinationViewController as ChooseRoomViewController
         chooseRoomViewController.selectedBuilding = building
      }
      if segue.identifier == "saveNewLocation" {
         let courseTitle = self.courseTitleTextField.text
         checkTextFields()
      
         location = Location(building: building!, room: room!,
            course: Course(name: courseTitle, daysAsString: days, startTime: startTime, endTime: endTime))
      }
   }
   
   func checkTextFields() {
      if self.courseTitleTextField.text.isEmpty {
         courseTitle = ""
      }
      if self.startTextField.text.isEmpty {
         startTime = ""
      }
      if self.endTextField.text.isEmpty {
         endTime = ""
      }
   }
   
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         courseTitleTextField.becomeFirstResponder()
      }
   }
}
