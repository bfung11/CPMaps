//
//  LocationsViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

class LocationsViewController: UITableViewController, UITableViewDataSource {
   
   @IBOutlet var locationsTableView: UITableView!
   
   var locations: CPMapsLibraryAPI!
   var selectedLocation: NSIndexPath?
   var isEditLocation: Bool?
   let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
   
   override func viewDidLoad() {
      super.viewDidLoad()
      locations = CPMapsLibraryAPI.sharedInstance
      locationsTableView.registerClass(LocationCell.self, forCellReuseIdentifier: locationCellReuseIdentifier)
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }

   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInLocationsViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return locations.getNumberOfLocations()
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
   -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(locationCellReuseIdentifier, forIndexPath: indexPath) as! LocationCell
      
      println(indexPath.row)
//      println(locations.getLocationBuildingNumber(self.indexPath!.row))
      println(locations.getBuildingNumberAtLocation(indexPath.row))
      let building = locations.getBuildingAtIndex(indexPath.row)
      
      cell.buildingLabel?.text =
         "Building " + building.getNumber() +
         " (" + building.getName() + ")"
      if locations.doesLocationHaveRoom(indexPath.row) {
         cell.roomLabel?.text =
            "Room " + locations.getRoomNumberAtLocation(indexPath.row)
      }
      else {
         cell.roomLabel?.text = ""
      }
      let location = locations.getLocation(indexPath.row)
      cell.timesLabel?.text = location.getName()
      return cell
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      self.selectedLocation = indexPath
      performSegueWithIdentifier(chooseLocationSegueIdentifier, sender: self)
   }
   
   override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
      self.selectedLocation = indexPath
      performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {    
      if segue.identifier == editLocationSegueIdentifier {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first
            as! AddEditLocationViewController
         viewController.selectedLocation = selectedLocation
         isEditLocation = true
      }
      else {
         isEditLocation = false
      }
   }
   
   @IBAction func cancelAddEditLocation(segue:UIStoryboardSegue) {
   }
   
   @IBAction func saveLocation(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! AddEditLocationViewController
      let selectedBuilding = locations.getBuildingAtIndex(viewController.buildingIndexPath.row).getName()
      
      if isEditLocation == true {
         locations.updateBuildingNumberAtLocation(index: viewController.selectedLocation.row, buildingNumber: selectedBuilding)
         locations.updateRoomNumberAtLocation(index: viewController.selectedLocation.row, roomNumber: viewController.selectedRoom!)
         self.tableView.reloadData() //may need to reload only one table cell
      }
      else {
         locations.addLocation(viewController.name,
            buildingNumber: selectedBuilding, roomNumber: viewController.selectedRoom,
            startTime: viewController.startTime, endTime: viewController.endTime,
            days: viewController.selectedDays)
         // update the tableView
         self.tableView.reloadData()
         let count = locations.getNumberOfLocations()
         println("num location \(count)\n")
         
         println("List of Locations")
         var index = 0;
         for (index = 0; index < count; ++index) {
            var num = locations.getBuildingNumberAtLocation(index)
            println("num location \(num)")
            let location = locations.getLocation(index)
            if location.hasName() {
               println(location.getName())
            }
         }
         let tempIndexPath = NSIndexPath(forRow: count, inSection: 0)
//         tableView.insertRowsAtIndexPaths([tempIndexPath], withRowAnimation: .Automatic)
      }
   }
}
