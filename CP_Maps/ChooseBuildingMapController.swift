//
//  ChooseBuildingMapController.swift
//  CP_Maps
//
//  Created by Carl Lind III on 4/30/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ChooseBuildingMapController: UITableViewController {
   var api: CPMapsLibraryAPI!       // building data or room data
   var buildingIndexPath: NSIndexPath? // selected building or room
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      api = CPMapsLibraryAPI.sharedInstance
      self.navigationItem.title = chooseBuildingViewControllerTitle
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInChooseBuildingRoomViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return api.getNumberOfBuildings()
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell: UITableViewCell?
      var building = api.getBuildingAtIndex(indexPath.row) // for readability
      
      // display buildings
      cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath) as? UITableViewCell
      cell!.textLabel?.text = api.getBuildingNumber(indexPath.row) + " - " +
         building.getBuildingName()
      cell!.accessoryType = .None //prevents random buildings from having checkmarks
      
      // if there is a selected building, put a checkmark next to the selected building
      if buildingIndexPath != nil && api.getBuildingAtIndex(buildingIndexPath!.row).getBuildingName() == building.getBuildingName() {
         cell!.accessoryType = .Checkmark
      }
      
      return cell!
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      self.buildingIndexPath = indexPath
      performSegueWithIdentifier(saveBuildingSegueIdentifer, sender: self)
   }
}

