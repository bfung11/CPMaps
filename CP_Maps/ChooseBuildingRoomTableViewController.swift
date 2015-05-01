//
//  ChooseBuildingRoomViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//
//  Description: Abstract class to choose building and choose room
//

import UIKit

class ChooseBuildingRoomViewController: UITableViewController {
   var identifier: String?      // determines whether to display building or room data 
   var data: CPMapsLibraryAPI!       // building data or room data
   var buildingIndexPath: NSIndexPath? // selected building or room
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      data = CPMapsLibraryAPI.sharedInstance
      self.navigationItem.title = chooseBuildingViewControllerTitle
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInChooseBuildingRoomViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.getNumberOfBuildings()
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell: UITableViewCell?
      var building = data.getBuildingAtIndex(indexPath.row) // for readability
      
      // display buildings
      cell = tableView.dequeueReusableCellWithIdentifier("BuildingRoomCell", forIndexPath: indexPath) as? UITableViewCell
      cell!.textLabel?.text = building.getBuildingNumber() + " - " +
         building.getName()
      cell!.accessoryType = .None //prevents random buildings from having checkmarks
      
      // if there is a selected building, put a checkmark next to the selected building
      if buildingIndexPath != nil && data.getBuildingAtIndex(buildingIndexPath!.row).getName() == building.getName() {
         cell!.accessoryType = .Checkmark
      }
      
      return cell!
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      self.buildingIndexPath = indexPath
      performSegueWithIdentifier(saveBuildingSegueIdentifer, sender: self)
   }
}
