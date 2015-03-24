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
   var data: [AnyObject]!       // building data or room data
   var selectedItem: AnyObject? // selected building or room
   var selectedItemIndex: Int?  // index of selected building or room
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      selectedItemIndex = nil
      
      // display correct controller title
      if identifier == chooseBuildingSegueIdentifier {
         self.navigationItem.title = chooseBuildingViewControllerTitle
      }
      else {
         self.navigationItem.title = chooseRoomViewControllerTitle
      }
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInChooseBuildingRoomViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell: UITableViewCell?
      
      if identifier == chooseBuildingSegueIdentifier {
         // display buildings
         cell = tableView.dequeueReusableCellWithIdentifier("BuildingRoomCell", forIndexPath: indexPath) as? UITableViewCell
         let building = data![indexPath.row] as Building
         cell!.textLabel?.text = building.number + " - " + building.name
         cell!.accessoryType = .None //prevents random buildings from having checkmarks
         
         // if there is a selected building, put a checkmark next to the selected building
         if selectedItem != nil && building.name == (selectedItem as Building).name {
            cell!.accessoryType = .Checkmark
         }
      }
      else if identifier == chooseRoomSegueIdentifier {
         // display rooms
         cell = tableView.dequeueReusableCellWithIdentifier("BuildingRoomCell", forIndexPath: indexPath) as? UITableViewCell
         let room = data![indexPath.row] as Room
         cell!.textLabel?.text = "Room " + room.number
         cell!.accessoryType = .None //prevents random room from having checkmarks
         
         // if there is a selected room, put a checkmark next to the selected room
         if selectedItem != nil && room.number == (selectedItem as Room).number{
            cell!.accessoryType = .Checkmark
         }
      }
      
      return cell!
   }
   
   //MARK: - Table view delegate
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      selectedItem = data![indexPath.row]
      if identifier == chooseBuildingSegueIdentifier {
         performSegueWithIdentifier(saveBuildingSegueIdentifer, sender: self)
      }
      else if identifier == chooseRoomSegueIdentifier {
         performSegueWithIdentifier(saveRoomSegueIdentifer, sender: self)
      }
   }
}
