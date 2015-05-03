//
//  LocationsViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

class LocationsViewController: UITableViewController, NSFetchedResultsControllerDelegate,
UITableViewDataSource {
   
   @IBOutlet var locationsTableView: UITableView!
   
   var locations: CPMapsLibraryAPI!
   var fetchedResultsController: NSFetchedResultsController!
   var selectedLocation: NSIndexPath?
   var isEditLocation: Bool?
   let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
   
   override func viewDidLoad() {
      super.viewDidLoad()
      locations = CPMapsLibraryAPI.sharedInstance
      locations.setDelegate(self)
      fetchedResultsController = locations.getNSFetchedResultsController()
      fetchedResultsController.performFetch(nil)
//      locationsTableView.registerClass(LocationCell.self, forCellReuseIdentifier: locationCellReuseIdentifier)
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return fetchedResultsController.sections!.count
      //      return numberOfSectionsInLocationsViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
      return sectionInfo.numberOfObjects
      //      return locations.getNumberOfLocations()
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
      -> UITableViewCell {
         let location = locations.getFetchedLocation(indexPath)
         let cell = tableView.dequeueReusableCellWithIdentifier(locationCellReuseIdentifier, forIndexPath: indexPath) as! LocationCell
         
         println(indexPath.row)
         //      println(locations.getLocationBuildingNumber(self.indexPath!.row))
         println(location.getBuildingNumber())
         let building = locations.getBuildingAtIndex(indexPath.row)
         
         cell.buildingLabel.text =
            "Building " + building.getNumber() +
            " (" + building.getName() + ")"
         if location.hasRoomNumber() {
            cell.roomLabel?.text =
               "Room " + location.getRoomNumber()
         }
         else {
            cell.roomLabel?.text = ""
         }
         cell.timesLabel?.text = "This is where cool text goes"
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
         let location = locations.getLocation(viewController.selectedLocation.row)
         location.updateBuildingNumber(selectedBuilding)
         location.updateRoomNumber(viewController.selectedRoom!)
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
         //         println("num location \(count)\n")
         //
         //         println("List of Locations")
         //         var index = 0;
         //         for (index = 0; index < count; ++index) {
         //            let location = locations.getLocation(index)
         //            let num = location.getBuildingNumber()
         //            println("building number \(num)")
         //            if location.hasName() {
         //               println(location.getName())
         //            }
         //         }
         let tempIndexPath = NSIndexPath(forRow: count, inSection: 0)
         //         tableView.insertRowsAtIndexPaths([tempIndexPath], withRowAnimation: .Automatic)
      }
   }
}
