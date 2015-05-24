//
//  ChooseDaysViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

/*! Accepts days as a string and converts them as selection in the 
    view controller. After user finishes, returns the selected days as a string.
*/
class ChooseDaysViewController: UITableViewController {
   var days: [Day]!                // days data
   var selectedDaysAsBool: [Bool]! // toggles for selecting and deselecting days
   var selectedDays: String!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // set up data
      days = daysData
      selectedDaysAsBool = [Bool](count: selectedDaysAsBoolInitialCount,
         repeatedValue: selectedDaysAsBoolIntialValue)      
      // if from adding a location
      if selectedDays == nil {
      }
      else {
         self.chooseDays(selectedDays)
      }
   }
   
   private func chooseDays(selectedDays: String) {
      let selectedDaysNSString = NSString(string: selectedDays)
      let arr = selectedDaysNSString.componentsSeparatedByString(", ")
      
      for day in arr {
         if (isDayChosen(day as! String)) {
            selectedDaysAsBool[indexForDay(day as! String)] = true
         }
      }
   }
   
   private func isDayChosen(day: String) -> Bool {
      return day == "Sunday" || day == "Monday" || day == "Tuesday" ||
         day == "Wednesday" || day == "Thursday" || day == "Friday" ||
         day == "Saturday"
   }
   
   private func indexForDay(day: String) -> Int {
      
      var index = -1
      
      switch day {
      case "Sunday":
         index = 0
      case "Monday":
         index = 1
      case "Tuesday":
         index = 2
      case "Wednesday":
         index = 3
      case "Thursday":
         index = 4
      case "Friday":
         index = 5
      case "Saturday":
         index = 6
      default: ()
      }
      
      return index
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInDaysViewController
   }
   
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return days.count
   }
   
   override func tableView(tableView: UITableView,
      cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      // add day to table cell and add checkmark if previously selected
      let cell = tableView.dequeueReusableCellWithIdentifier("DayCell",
         forIndexPath: indexPath) as! UITableViewCell
      cell.textLabel?.text = getDay(indexPath.row)
      if selectedDaysAsBool[indexPath.row] == true {
         cell.accessoryType = .Checkmark
      }
   
      return cell
   }
   
   //MARK: - Table view delegate
   override func tableView(tableView: UITableView,
      didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
      // if user selects it, add a checkmark; 
      // if user unselects it, remove checkmark
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      let index = indexPath.row
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      if selectedDaysAsBool[index] == true {
         selectedDaysAsBool[index] = false
         cell?.accessoryType = .None
      }
      else {
         selectedDaysAsBool[index] = true
         cell?.accessoryType = .Checkmark
      }      
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      var index: Int
      selectedDays = "" // clear - not sure if necessary
      
      // convert the selectedDays as Bool to string
      for (index = 0; index < selectedDaysAsBool.count; ++index) {
         if (selectedDaysAsBool[index] == true) {
            selectedDays! += getDay(index) + ", "
         }
      }
      
      // remove the final comma, if possible
      let temp = NSString(string: selectedDays)
      if (temp.length > 0) {
         selectedDays = temp.substringToIndex(temp.length - 2)
      }
   }
   
   private func getDay(index: Int) -> String {
      var day = ""
      
      switch index {
      case 0:
         day = "Sunday"
      case 1:
         day = "Monday"
      case 2:
         day = "Tuesday"
      case 3:
         day = "Wednesday"
      case 4:
         day = "Thursday"
      case 5:
         day = "Friday"
      case 6:
         day = "Saturday"
      default: ()
      }
      
      return day
   }
}
