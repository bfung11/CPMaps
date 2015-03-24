//
//  ChooseDaysViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ChooseDaysViewController: UITableViewController {
   var days: [Day]! //show days of the week
   var selectedDay: Day?
   var selectedDayIndex: Int?
   var selectedDaysAsBool: [Bool]!
   var selectedDays: [Day]?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      days = daysData
      selectedDay = nil
      selectedDayIndex = nil
      selectedDaysAsBool = [Bool](count: selectedDaysAsBoolInitialCount, repeatedValue: selectedDaysAsBoolIntialValue)
      selectedDays = [Day]()
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
      
      if indexPath.row == selectedDayIndex {
         cell.accessoryType = .Checkmark
      } else {
         cell.accessoryType = .None
      }
      return cell
   }
   
   //MARK: - Table view delegate
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      selectedDayIndex = indexPath.row
      selectedDay = days[indexPath.row]
      
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      //if has been selected, unselect it; else select it
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
      for var index = 0; index < selectedDaysAsBool.count; ++index {
         if selectedDaysAsBool[index] == true {
            selectedDays!.append(days[index])
         }
      }
   }
}
