//
//  LocationsViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class LocationsViewController: UITableViewController {
   
   var locations: LocationsLibraryAPI!
   var indexPath: NSIndexPath?
   var isEditLocation: Bool?
   let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      locations = LocationsLibraryAPI.sharedInstance
      

      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   // MARK: - Table view data source
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInLocationsViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return locations.getNumberOfLocations()
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
   -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(locationCellReuseIdentifier, forIndexPath: indexPath) as! LocationCell
      
      cell.buildingTitleLabel.text =
         "Building " + locations.getLocationBuildingNumber(indexPath.row) +
         " (" + locations.getLocationBuildingName(indexPath.row) + ")"
      if locations.locationHasRoom(indexPath.row) {
         cell.roomTitleLabel.text =
            "Room " + locations.getLocationRoomNumber(indexPath.row)
      }
      else {
         cell.roomTitleLabel.text = ""
      }
      cell.classTitleLabel.text = locations.getLocationName(indexPath.row)
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
      
      if isEditLocation == true {
         locations.updateLocationBuildingNumber(index: viewController.indexPath.row, buildingNumber: viewController.selectedBuilding!)
         locations.updateLocationRoomNumber(index: viewController.indexPath.row, roomNumber: viewController.selectedRoom!)
         
         self.tableView.reloadData() //may need to reload only one table cell
      }
      else {
         locations.addLocation(viewController.name, buildingNumber: viewController.selectedBuilding!, roomNumber: viewController.selectedRoom, startTime: viewController.startTime, endTime: viewController.endTime, days: viewController.selectedDays, insertIntoManagedObjectContext: self.managedObjectContext)
         
         // update the tableView
         self.tableView.reloadData()
         
         let count = locations.getNumberOfLocations()
         
         println("\(count) add\n\n\n\n\n")
         
         let indexPath = NSIndexPath(forRow: count, inSection: 0)
         tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
         println("after")
      }
   }
}
