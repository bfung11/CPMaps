//
//  ChooseBuildingViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ChooseBuildingViewController: UITableViewController {
   var buildings: [String] = buildingsData
   var selectedBuilding: String? = nil
   var selectedBuildingIndex:Int? = nil

   override func viewDidLoad() {
      super.viewDidLoad()
   }

   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }

   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return buildings.count
   }

   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath) as UITableViewCell
      cell.textLabel?.text = buildings[indexPath.row]

      if indexPath.row == selectedBuildingIndex {
         cell.accessoryType = .Checkmark
      }
      else {
         cell.accessoryType = .None
      }
      return cell
   }



   //MARK: - Table view delegate
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)

      //Other row is selected - need to deselect it
      if let index = selectedBuildingIndex {
         let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
         cell?.accessoryType = .None
      }

      selectedBuildingIndex = indexPath.row
      selectedBuilding = buildings[indexPath.row]

      //update the checkmark for the current row
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      cell?.accessoryType = .Checkmark
   }
}
