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
   var selectedDayIndex: Int?
   var selectedDaysAsBool: [Bool]!
   var selectedDays: [Day]?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      days = daysData
      selectedDayIndex = nil
      selectedDaysAsBool = [Bool](count: selectedDaysAsBoolInitialCount, repeatedValue: selectedDaysAsBoolIntialValue)
      if selectedDays == nil {
         selectedDays = [Day]()
      }
      else { //from edit location, set correct days as true for checkmarks
         for day in selectedDays! {
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
      cell.accessoryType = .None
      
      if selectedDaysAsBool[indexPath.row] == true {
         cell.accessoryType = .Checkmark
      }
   
      return cell
   }
   
   //MARK: - Table view delegate
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      selectedDayIndex = indexPath.row
      
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
      selectedDays = [Day]() //refresh the list and start over
      for var index = 0; index < selectedDaysAsBool.count; ++index {
         if selectedDaysAsBool[index] == true {
            selectedDays!.append(days![index])
         }
      }
   }
}
