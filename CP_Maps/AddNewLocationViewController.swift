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
   
   @IBOutlet weak var buildingNameDetail: UILabel!
   @IBOutlet weak var roomNumberDetail: UILabel!
   @IBOutlet weak var classNameTextField: UITextField!
   @IBOutlet weak var classTimesTextField: UITextField!

   @IBAction func cancelAddDetails(segue:UIStoryboardSegue) {
   }
   
   @IBAction func saveNewLocationDetails(segue:UIStoryboardSegue) {
      var textFields = [String]()
      
      switch segue.identifier! {
         case "saveBuilding":
            let chooseBuildingViewController = segue.sourceViewController as ChooseBuildingViewController
            //convert building text from controller into elements of an array
            textFields = chooseBuildingViewController.selectedBuilding!.componentsSeparatedByString(" ")
            //add building number
            buildingNumber = textFields[0]
            //remove the number in front
            textFields.removeAtIndex(0)
            //combine them back into name
            buildingName = " ".join(textFields)
         case "saveRoom":
            let chooseRoomViewController = segue.sourceViewController as ChooseRoomViewController
            //convert building text from controller into elements of an array
            textFields = chooseRoomViewController.selectedRoom!.componentsSeparatedByString(" ")
            //grab only the room number
            roomNumber = textFields[1]
         case "saveDays":
            let chooseDaysViewController = segue.sourceViewController as ChooseDaysViewController
            days = chooseDaysViewController.selectedDays
         default: ()
      }
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      var tempClassName = self.classNameTextField.text
      var tempDays = days
      var tempClassTimes = self.classTimesTextField.text
      
      if self.classNameTextField.text.isEmpty {
         tempClassName = ""
      }
      if days.isEmpty {
         tempDays = [String]()
      }
      if self.classTimesTextField.text.isEmpty{
         tempClassTimes = ""
      }
      
      if segue.identifier == "saveNewLocation" {
         location = Location(buildingName: buildingName, buildingNumber: buildingNumber,
            roomNumber: roomNumber, className: tempClassName,
            classDaysArray: tempDays, classTimes: tempClassTimes)
      }
   }
   
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         classNameTextField.becomeFirstResponder()
      }
   }
}
