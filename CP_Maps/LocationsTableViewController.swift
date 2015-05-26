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
   var selectedLocation: Location?
   var selectedLocationIndexPath: NSIndexPath?
   var isEditLocation: Bool?
   let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
   
   override func viewDidLoad() {
      super.viewDidLoad()
      locations = CPMapsLibraryAPI.sharedInstance
      fetchedResultsController = CPMapsLibraryAPI.sharedInstance
      fetchedResultsController.setDelegate(self)
      fetchedResultsController.performFetch(nil)
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
      self.selectedLocation = self.locations.getLocation(indexPath)
      performSegueWithIdentifier(chooseLocationSegueIdentifier, sender: self)
   }
   
   override func tableView(tableView: UITableView,
      canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
       return true
   }
   
   override func tableView(tableView: UITableView,
      editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
         
      var editAction = UITableViewRowAction(style: .Default, title: "Edit",
         handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            self.selectedLocation = self.locations.getLocation(indexPath)
            self.performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
         }
      )
      editAction.backgroundColor = UIColor.lightGrayColor()
      
      var deleteAction = UITableViewRowAction(style: .Normal, title: "Delete",
         handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            self.presentSettingsActionSheet(indexPath)
         }
      )
      deleteAction.backgroundColor = UIColor.redColor()
      
      return [deleteAction, editAction]
   }
   
   private func presentSettingsActionSheet(indexPath: NSIndexPath) {
      let settingsActionSheet: UIAlertController = UIAlertController(title:nil, message:nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
//      settingsActionSheet.addAction(UIAlertAction(title:"Send Feedback", style:UIAlertActionStyle.Default, handler:{ action in
////         self.presentFeedbackForm()
//      }))
      settingsActionSheet.addAction(UIAlertAction(title:"Delete", style:UIAlertActionStyle.Default, handler:{ action in
         let location = self.locations.getLocation(indexPath)
         self.locations.deleteLocation(location)
         self.locations.performFetch(nil)
         self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      }))
      settingsActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
      presentViewController(settingsActionSheet, animated:true, completion:nil)
   }
   
   /*! Called when a row deletion action is confirmed
   */
   override func tableView(tableView: UITableView,
      commitEditingStyle editingStyle: UITableViewCellEditingStyle,
      forRowAtIndexPath indexPath: NSIndexPath) {
   }
   
   func controllerDidChangeContent(controller: NSFetchedResultsController) {
      self.tableView.reloadData()
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == editLocationSegueIdentifier {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first
            as! AddEditLocationViewController
         viewController.selectedLocation = self.selectedLocation
         isEditLocation = true
      }
      else {
         isEditLocation = false
      }
   }
   
   @IBAction func saveLocation(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! AddEditLocationViewController
      let buildingNumber = viewController.selectedBuilding.getNumber()
      
      if isEditLocation == true {
         let location = viewController.selectedLocation
         location.update(viewController.name,
            buildingNumber: buildingNumber, roomNumber: viewController.selectedRoom,
            startTime: viewController.startTime, endTime: viewController.endTime,
            days: viewController.selectedDays)
         self.tableView.reloadData() //may need to reload only one table cell
      }
      else {
         locations.addLocation(viewController.name,
            buildingNumber: buildingNumber, roomNumber: viewController.selectedRoom,
            startTime: viewController.startTime, endTime: viewController.endTime,
            days: viewController.selectedDays)
      }
   }
   
   @IBAction func cancelAddEditLocation(segue:UIStoryboardSegue) {
   }
   
   @IBAction func cancelToLocationsTableViewController(segue:UIStoryboardSegue) {
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
         days = self.convertToShortName(days)
      }
      
      return days
   }
   
   private func convertToShortName(selectedDays: String) -> String {
      var shortName = ""
      let selectedDaysNSString = NSString(string: selectedDays)
      let arr = selectedDaysNSString.componentsSeparatedByString(", ")
      
      for day in arr {
         shortName += getShortName(day as! String)
      }
      
      return shortName
   }
   
   private func getShortName(longName: String) -> String {
      var shortName = "Please select a day"
      
      switch longName {
      case "Sunday":
         shortName = "Su"
      case "Monday":
         shortName = "M"
      case "Tuesday":
         shortName = "Tu"
      case "Wednesday":
         shortName = "W"
      case "Thursday":
         shortName = "Th"
      case "Friday":
         shortName = "F"
      case "Saturday":
         shortName = "Sa"
      default: ()
      }
      
      return shortName
   }
}
