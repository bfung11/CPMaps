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
   @IBOutlet weak var roomDetail: UILabel!
   @IBOutlet weak var classNameTextField: UITextField!
   @IBOutlet weak var daysDetail: UILabel!
   @IBOutlet weak var startDatePicker: UIDatePicker!
   @IBOutlet weak var startTextField: UITextField!
   @IBOutlet weak var endTextField: UITextField!
   @IBOutlet weak var endDatePicker: UIDatePicker!
   
   var location: Location! //exclamation point - does not instantiate, but must do so before use
   var buildingName: String!
   var buildingNumber: String!
   var roomNumber: String!
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
            //save building details
            let chooseBuildingViewController = segue.sourceViewController as ChooseBuildingViewController
            let building = chooseBuildingViewController.selectedBuilding
            buildingName = building!.name
            buildingNumber = building!.number
            //update building detail to reflect selection
            buildingDetail.text = "Building " + buildingNumber + " (" + buildingName + ")"
         case "saveRoom":
            //save room details
            let chooseRoomViewController = segue.sourceViewController as ChooseRoomViewController
            roomNumber = chooseRoomViewController.selectedRoom
            //update room detail to reflect selection
            roomDetail.text = "Room " + roomNumber
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
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "saveNewLocation" { //leave in, so cancel segues don't do anything
         var tempClassName = self.classNameTextField.text
        
         if self.classNameTextField.text.isEmpty {
            tempClassName = ""
         }
         
         if segue.identifier == "saveNewLocation" {
            location = Location(buildingName: buildingName, buildingNumber: buildingNumber,
               roomNumber: roomNumber, courseName: tempClassName,
               daysAsString: days, startTime: startTime, endTime: endTime)
         }
      }
   }
   
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         classNameTextField.becomeFirstResponder()
      }
   }
}
