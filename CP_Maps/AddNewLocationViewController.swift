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
   var building: String!
   var room: String!
   var days: String!
   
   @IBOutlet weak var buildingNameDetail: UILabel!
   @IBOutlet weak var roomNumberDetail: UILabel!
   @IBOutlet weak var classNameTextField: UITextField!
   @IBOutlet weak var classTimesTextField: UITextField!

   @IBAction func saveNewLocationDetails(segue:UIStoryboardSegue) {
      if segue.identifier == "saveBuilding" {
         let chooseBuildingViewController = segue.sourceViewController as ChooseBuildingViewController
         building = chooseBuildingViewController.selectedBuilding
      }
      if segue.identifier == "saveRoom" {
         let chooseRoomViewController = segue.sourceViewController as ChooseRoomViewController
         room = chooseRoomViewController.selectedRoom
      }
      /*
      if segue.identifier == "saveDays" {
         let chooseDaysViewController = segue.sourceViewController as ChooseDaysViewController
         days = chooseDaysViewController.selectedDays
      }
*/
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "saveNewLocation" {
         location = Location(buildingName: building, buildingNumber: "14",
            roomNumber: room, className: self.classNameTextField.text,
            classDays: "MWF",
            classTimes: self.classTimesTextField.text)
      }
   }
   
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         classNameTextField.becomeFirstResponder()
      }
   }
}
