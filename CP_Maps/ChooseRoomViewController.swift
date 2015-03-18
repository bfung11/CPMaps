//
//  ChooseRoomViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ChooseRoomViewController: UITableViewController {
   var selectedBuilding: Building!
   var selectedRoom: Room?
   var selectedRoomIndex:Int? = nil
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return selectedBuilding!.rooms.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("RoomCell", forIndexPath: indexPath) as UITableViewCell
      cell.textLabel?.text = "Room " + selectedBuilding!.rooms[indexPath.row].number
      
      if indexPath.row == selectedRoomIndex {
         cell.accessoryType = .Checkmark
      } else {
         cell.accessoryType = .None
      }
      return cell
   }
   
   //MARK: - Table view delegate
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      
//      //Other row is selected - need to deselect it
//      if let index = selectedRoomIndex {
//         let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
//         cell?.accessoryType = .None
//      }
//      selectedRoomIndex = indexPath.row
      selectedRoom = selectedBuilding!.rooms[indexPath.row]
//
//      //update the checkmark for the current row
//      let cell = tableView.cellForRowAtIndexPath(indexPath)
//      cell?.accessoryType = .Checkmark
      
      performSegueWithIdentifier("saveRoom", sender: self)
   }
}
