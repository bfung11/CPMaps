//
//  LocationDetailsViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UITableViewController {
   
   var location: Location! //exclamation point - does not instantiate, but must do so before use
   
   @IBOutlet weak var buildingNameDetail: UILabel!
   @IBOutlet weak var roomNumberDetail: UILabel!
   @IBOutlet weak var classNameTextField: UITextField!
   @IBOutlet weak var classDaysTextField: UITextField!
   @IBOutlet weak var classTimesTextField: UITextField!
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "saveLocationDetails" {
         location = Location(buildingName: "Frank E. Pilling", buildingNumber: "14",
            roomNumber: "259", className: self.classNameTextField.text,
            classDays: self.classDaysTextField.text, classTimes: self.classTimesTextField.text)
      }
   }
  
   //Allows user to tap anywhere in cell to bring up keyboard
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if indexPath.section == 0 {
         classNameTextField.becomeFirstResponder()
      }
   }
}
