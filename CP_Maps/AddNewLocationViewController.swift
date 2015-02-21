//
//  AddNewLocationViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class AddNewLocationViewController: UITableViewController {
   var location: Location! //exclamation point - does not instantiate, but must do so before use
   var buildingName: String!
   var buildingNumber: String!
   var roomNumber: String!
   var days = [String]()
   
   @IBOutlet weak var buildingDetail: UILabel!
   @IBOutlet weak var roomDetail: UILabel!
   @IBOutlet weak var classNameTextField: UITextField!
   @IBOutlet weak var daysDetail: UILabel!
   @IBOutlet weak var classTimesTextField: UITextField!

   @IBAction func cancelAddDetails(segue:UIStoryboardSegue) {
   }
   
   @IBAction func saveNewLocationDetails(segue:UIStoryboardSegue) {
      var labels = [String]()
      var daysTitle = ""
      var day : String
      
      switch segue.identifier! {
         case "saveBuilding":
            let chooseBuildingViewController = segue.sourceViewController as ChooseBuildingViewController
            //update building detail to reflect selection
            buildingDetail.text = chooseBuildingViewController.selectedBuilding
            //convert building text from controller into elements of an array
            labels = chooseBuildingViewController.selectedBuilding!.componentsSeparatedByString(" ")
            //add building number
            buildingNumber = labels[0]
            //remove the number in front
            labels.removeAtIndex(0)
            //combine them back into name
            buildingName = " ".join(labels)
         case "saveRoom":
            let chooseRoomViewController = segue.sourceViewController as ChooseRoomViewController
            //update room detail to reflect selection
            roomDetail.text = chooseRoomViewController.selectedRoom
            //convert building text from controller into elements of an array
            labels = chooseRoomViewController.selectedRoom!.componentsSeparatedByString(" ")
            //grab only the room number
            roomNumber = labels[1]
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
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      var tempClassName = self.classNameTextField.text
      var tempClassTimes = self.classTimesTextField.text
      
      if self.classNameTextField.text.isEmpty {
         tempClassName = ""
      }
      if self.classTimesTextField.text.isEmpty{
         tempClassTimes = ""
      }
      
      if segue.identifier == "saveNewLocation" {
         location = Location(buildingName: buildingName, buildingNumber: buildingNumber,
            roomNumber: roomNumber, courseName: tempClassName,
            daysAsString: days, courseTimes: tempClassTimes)
      }
   }
   
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         classNameTextField.becomeFirstResponder()
      }
   }
}
