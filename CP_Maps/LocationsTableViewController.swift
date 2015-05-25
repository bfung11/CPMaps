//
//  LocationsTableViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

class LocationsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,
UITableViewDataSource {
      
   var locations: CPMapsLibraryAPI!
   var fetchedResultsController: CPMapsLibraryAPI!
   var selectedLocationIndexPath: NSIndexPath?
   var isEditLocation: Bool?
   let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
   
   override func viewDidLoad() {
      super.viewDidLoad()
      locations = CPMapsLibraryAPI.sharedInstance
      fetchedResultsController = CPMapsLibraryAPI.sharedInstance
      fetchedResultsController.setDelegate(self)
      fetchedResultsController.performFetch(nil)
//      self.editing = true
//      locationsTableView.registerClass(LocationCell.self, forCellReuseIdentifier: locationCellReuseIdentifier)
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return fetchedResultsController.getNumberOfSectionsInTableView()
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return fetchedResultsController.getNumberOfRowsInSection(section)
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
      -> UITableViewCell {
         let cell = tableView.dequeueReusableCellWithIdentifier(locationCellReuseIdentifier, forIndexPath: indexPath) as! LocationCell
         let location = locations.getLocation(indexPath)
         let building = locations.getBuilding(location.getBuildingNumber())
         cell.buildingLabel.text =
            "Building " + building.getNumber() +
            " (" + building.getName() + ")"
         if location.hasRoomNumber() {
            cell.roomLabel?.text =
               "Room " + location.getRoomNumber()!
         }
         else {
            cell.roomLabel?.text = ""
         }
         cell.locationDetailsLabel?.text = getName(location) + " " + 
            getTime(location) + " " + getDays(location)
         return cell
   }
   
   override func tableView(tableView: UITableView,
      didSelectRowAtIndexPath indexPath: NSIndexPath) {
         
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      self.selectedLocationIndexPath = indexPath
      performSegueWithIdentifier(chooseLocationSegueIdentifier, sender: self)
   }
   
   override func tableView(tableView: UITableView!,
      canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
       return true
   }
   
   override func tableView(tableView: UITableView,
      editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
         
      var editAction = UITableViewRowAction(style: .Default, title: "Edit",
         handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            self.selectedLocationIndexPath = indexPath
            self.performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
         }
      )
      editAction.backgroundColor = UIColor.lightGrayColor()
      
      var deleteAction = UITableViewRowAction(style: .Normal, title: "Delete",
         handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            let location = self.locations.getLocation(indexPath)
            self.locations.deleteLocation(location)
            self.locations.performFetch(nil)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
         }
      )
      deleteAction.backgroundColor = UIColor.redColor()
      
      return [deleteAction, editAction]
   }
   
   /*! Called when a row deletion action is confirmed
   */
   override func tableView(tableView: UITableView,
      commitEditingStyle editingStyle: UITableViewCellEditingStyle,
      forRowAtIndexPath indexPath: NSIndexPath) {
//         switch editingStyle {
////         case .Delete:
////            // remove the deleted item from the model
////            let location = locations.getLocation(indexPath)
////            locations.deleteLocation(location)
////            
////            // Refresh the table view to indicate that it's deleted
////            locations.performFetch(nil)
////            // remove the deleted item from the `UITableView`
////            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//         default: ()
//         }
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == editLocationSegueIdentifier {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first
            as! AddEditLocationViewController
         viewController.selectedLocation = selectedLocationIndexPath
         isEditLocation = true
      }
      else {
         isEditLocation = false
      }
   }
   
   func controllerDidChangeContent(controller: NSFetchedResultsController) {
      self.tableView.reloadData()
   }
   
   @IBAction func cancelAddEditLocation(segue:UIStoryboardSegue) {
   }
   
   @IBAction func cancelToLocationsTableViewController(segue:UIStoryboardSegue) {
   }
   
   @IBAction func saveLocation(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! AddEditLocationViewController
      let buildingNumber = locations.getBuildingAtIndex(viewController.buildingIndexPath.row).getNumber()
      
      if isEditLocation == true {
         let location = locations.getLocation(viewController.selectedLocation)
         location.updateBuildingNumber(buildingNumber)
         location.updateRoomNumber(viewController.selectedRoom!)
         self.tableView.reloadData() //may need to reload only one table cell
      }
      else {
         locations.addLocation(viewController.name,
            buildingNumber: buildingNumber, roomNumber: viewController.selectedRoom,
            startTime: viewController.startTime, endTime: viewController.endTime,
            days: viewController.selectedDays)
      }
   }
   
   private func getName(location: Location) -> String {
      var name = ""
      
      if (location.getName() != nil) {
         name = location.getName()!
      }
      
      return name
   }
   
   private func getTime(location: Location) -> String {
      return location.startTime! + " - " + location.endTime!
   }
   
   private func getDays(location: Location) -> String {
      var days = ""
      
      if (location.getDays() != nil) {
         days = location.getDays()!
      }
      
      return days
   }
}
