//
//  ChooseDaysViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ChooseDaysViewController: UITableViewController {
   var days: [String]! //show days of the week
   var selectedDay: String?
   var selectedDayIndex: Int?
   var selectedDays: [String]!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      days = daysData
      selectedDay = nil
      selectedDayIndex = nil
      selectedDays = [String]()
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return days.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("DayCell", forIndexPath: indexPath) as UITableViewCell
      cell.textLabel?.text = days[indexPath.row]
      
      if indexPath.row == selectedDayIndex {
         cell.accessoryType = .Checkmark
      } else {
         cell.accessoryType = .None
      }
      return cell
   }
   
   //MARK: - Table view delegate
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      var i : Int
      var count : Int
      var day : String
      
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      selectedDayIndex = indexPath.row
      selectedDay = days[indexPath.row]
      
      //if selected day is in array, remove; else add
      if !selectedDays.isEmpty {
         count = selectedDays.count
         for (i = 0; i < count; ++i) {
            if selectedDay == selectedDays[i]  {
               selectedDays.removeAtIndex(i)
            }
            else {
               selectedDays.append(selectedDay!)
            }
         }
      }
      else {
         selectedDays.append(selectedDay!)
      }
      
      //update the checkmark for the current row
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      cell?.accessoryType = .Checkmark
   }
}
