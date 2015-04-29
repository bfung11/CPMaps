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
   var indexPath: NSIndexPath?
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
      
      cell.buildingLabel?.text =
         "Building " + locations.getLocationBuildingNumber(indexPath.row) +
         " (" + locations.getLocationBuildingName(indexPath.row) + ")"
      if locations.locationHasRoom(indexPath.row) {
         cell.roomLabel?.text =
            "Room " + locations.getLocationRoomNumber(indexPath.row)
      }
      else {
         cell.roomLabel?.text = ""
      }
      cell.timesLabel?.text = locations.getLocationName(indexPath.row)
      return cell
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      
      self.indexPath = indexPath
      performSegueWithIdentifier(chooseLocationSegueIdentifier, sender: self)
   }
   
   override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
      self.indexPath = indexPath
      performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {    
      if segue.identifier == editLocationSegueIdentifier {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first
            as! AddEditLocationViewController
         viewController.indexPath = indexPath
         isEditLocation = true
      }
      else {
         isEditLocation = false
      }
   }
   
   @IBAction func cancelAddEditLocation(segue:UIStoryboardSegue) {
      //dismissViewControllerAnimated(true, completion: nil)
      //performSegueWithIdentifier("cancelToMyLocations", sender: self)
   }
   
   @IBAction func saveLocation(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! AddEditLocationViewController
      let selectedBuilding = locations.getBuildingName(viewController.buildingIndexPath.row)
      
      
      if isEditLocation == true {
         locations.updateLocationBuildingNumber(index: viewController.indexPath.row, buildingNumber: selectedBuilding)
         locations.updateLocationRoomNumber(index: viewController.indexPath.row, roomNumber: viewController.selectedRoom!)
         
         self.tableView.reloadData() //may need to reload only one table cell
      }
      else {
         locations.addLocation(viewController.name, buildingNumber: selectedBuilding, roomNumber: viewController.selectedRoom, startTime: viewController.startTime, endTime: viewController.endTime, days: viewController.selectedDays)

         // update the tableView
         self.tableView.reloadData()
         let count = locations.getNumberOfLocations()
         println("num location \(count)\n")
         
         println("List of Locations")
         var index = 0;
         for (index = 0; index < count; ++index) {
            var name = locations.getLocationBuildingNumber(index)
            println("num location \(name)")
            if locations.locationHasName(index) {
               println("hasName")
            }
         }
         let indexPath = NSIndexPath(forRow: count, inSection: 0)
//         tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
   }
}
