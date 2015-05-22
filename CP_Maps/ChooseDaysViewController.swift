//
//  ChooseDaysViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ChooseDaysViewController: UITableViewController {
   var days: [Day]!                // days data
   var selectedDayIndex: Int?
   var selectedDaysAsBool: [Bool]! // toggles for selecting and deselecting days
   var selectedDaysAsDays: [Day]?        // final selection of days
   var selectedDays: String!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // set up data
      days = daysData
      selectedDayIndex = nil
      selectedDaysAsBool = [Bool](count: selectedDaysAsBoolInitialCount,
         repeatedValue: selectedDaysAsBoolIntialValue)
      
      // if from adding a location
      if selectedDays == nil {
         selectedDaysAsDays = [Day]()
      }
      else {
         selectedDays = "Monday, Tuesday, Saturday" // will need to change late
         println("here")
         for day in selectedDaysAsDays! { // set days that need checkmarks
            selectedDaysAsBool[day.value] = true
         }
      }
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInDaysViewController
   }
   
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return days.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("DayCell", forIndexPath: indexPath) as! UITableViewCell
      cell.textLabel?.text = days[indexPath.row].name
//      cell.accessoryType = .None // mark all days as none to prevent random days from having checkmarks
      if selectedDaysAsBool[indexPath.row] == true { // if day was selected
         cell.accessoryType = .Checkmark
      }
   
      return cell
   }
   
   //MARK: - Table view delegate
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      let index = indexPath.row
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      // if has been selected, unselect it; else select it
      
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
      
      for (index = 0; index < selectedDaysAsBool.count; ++index) {
         if (selectedDaysAsBool[index] == true) {
            selectedDays! += getDay(index) + ", "
         }
      }
      
      var temp = NSString(string: selectedDays)
      selectedDays = temp.substringToIndex(temp.length - 2)
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
