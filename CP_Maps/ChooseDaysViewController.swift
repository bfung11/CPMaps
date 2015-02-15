//
//  ChooseDaysViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ChooseDaysViewController: UITableViewController {
   var days: [String] = daysData
   var selectedDays: String? = nil
   var selectedDaysIndex: Int? = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()

   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return days.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("DaysCell", forIndexPath: indexPath) as UITableViewCell
      cell.textLabel?.text = days[indexPath.row]
      
      if indexPath.row == selectedDaysIndex {
         cell.accessoryType = .Checkmark
      } else {
         cell.accessoryType = .None
      }
      return cell
   }
   
   //MARK: - Table view delegate
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      
      selectedDaysIndex = indexPath.row
      selectedDays = days[indexPath.row]
      
      //update the checkmark for the current row
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      cell?.accessoryType = .Checkmark
   }
}
