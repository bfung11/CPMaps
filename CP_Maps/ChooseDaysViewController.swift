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
   var selectedDays: [Day]?        // final selection of days
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // set up data
      days = daysData
      selectedDayIndex = nil
      selectedDaysAsBool = [Bool](count: selectedDaysAsBoolInitialCount, repeatedValue: selectedDaysAsBoolIntialValue)
      
      // if from adding a location
      if selectedDays == nil {
         selectedDays = [Day]()
      }
      else {
         for day in selectedDays! { // set days that need checkmarks
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
      let cell = tableView.dequeueReusableCellWithIdentifier("DayCell", forIndexPath: indexPath) as UITableViewCell
      cell.textLabel?.text = days[indexPath.row].name
      cell.accessoryType = .None // mark all days as none to prevent random days from having checkmarks
      if selectedDaysAsBool[indexPath.row] == true { // if day was selected
         cell.accessoryType = .Checkmark
      }
   
      return cell
   }
   
   //MARK: - Table view delegate
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      selectedDayIndex = indexPath.row
      
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      // if has been selected, unselect it; else select it
      if selectedDaysAsBool[selectedDayIndex!] == true {
         selectedDaysAsBool[selectedDayIndex!] = false
         cell?.accessoryType = .None
      }
      else {
         selectedDaysAsBool[selectedDayIndex!] = true
         cell?.accessoryType = .Checkmark
      }      
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      selectedDays = [Day]() // destroy the old list and count just the curently selected days
      // add all selected days into final selection
      for var index = 0; index < selectedDaysAsBool.count; ++index {
         if selectedDaysAsBool[index] == true {
            selectedDays!.append(days![index])
         }
      }
   }
}
