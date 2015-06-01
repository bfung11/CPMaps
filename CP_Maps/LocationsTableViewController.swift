//
//  LocationsTableViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

class LocationsTableViewController: UIViewController, NSFetchedResultsControllerDelegate,
UITableViewDataSource, UITableViewDelegate {
      
   @IBOutlet var locationsTableView: UITableView!
   @IBOutlet weak var locationsToolbar: UIToolbar!
      
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
      
      self.locationsTableView.delegate = self
      self.locationsTableView.dataSource = self
      
      var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
      swipeRight.direction = UISwipeGestureRecognizerDirection.Right
      self.view.addGestureRecognizer(swipeRight)
      
      var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
      swipeDown.direction = UISwipeGestureRecognizerDirection.Down
      self.view.addGestureRecognizer(swipeDown)
      
      var longPress = UILongPressGestureRecognizer(target: self, action: "respondToLongPress:")
      self.view.addGestureRecognizer(longPress)
   }
   
   func respondToSwipeGesture(gesture: UIGestureRecognizer) {
      
      if let swipeGesture = gesture as? UISwipeGestureRecognizer {
         
         switch swipeGesture.direction {
         case UISwipeGestureRecognizerDirection.Right:
            println("Swiped right")
         case UISwipeGestureRecognizerDirection.Down:
            println("Swiped down")
         default:
            break
         }
      }
   }
   
   func respondToLongPress(gesture: UIGestureRecognizer) {
      if let longPressGesture = gesture as? UILongPressGestureRecognizer {
         println("Long Press")
      }
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return fetchedResultsController.getNumberOfSectionsInTableView()
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return fetchedResultsController.getNumberOfRowsInSection(section)
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
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
   
   func tableView(tableView: UITableView,
      didSelectRowAtIndexPath indexPath: NSIndexPath) {
         
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
         self.selectedLocation = self.locations.getLocation(indexPath)
         performSegueWithIdentifier(chooseLocationSegueIdentifier, sender: self)
   }
   
   func tableView(tableView: UITableView,
      accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
         self.presentAllOptionsActionSheet(indexPath)
   }
   
   func tableView(tableView: UITableView,
      canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
         return true
   }
   
   func tableView(tableView: UITableView,
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
               self.presentDeleteActionSheet(indexPath)
            }
         )
         deleteAction.backgroundColor = UIColor.redColor()
         
         return [deleteAction, editAction]
   }
   
   func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
      return true
   }
   
   func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
      //      var itemToMove = tableData[fromIndexPath.row]
      //      tableData.removeAtIndex(fromIndexPath.row)
      //      tableData.insert(itemToMove, atIndex: toIndexPath.row)
   }
   
   /*! Called when a row deletion action is confirmed
   */
   func tableView(tableView: UITableView,
      commitEditingStyle editingStyle: UITableViewCellEditingStyle,
      forRowAtIndexPath indexPath: NSIndexPath) {
   }
   
   func controllerDidChangeContent(controller: NSFetchedResultsController) {
      self.locationsTableView.reloadData()
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
         self.locationsTableView.reloadData() //may need to reload only one table cell
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
   
   private func deleteLocation(indexPath: NSIndexPath) {
      let location = self.locations.getLocation(indexPath)
      self.locations.deleteLocation(location)
      self.locations.performFetch(nil)
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
   
   /* ----Start of UIActionSheet functions---- */
   private func presentAllOptionsActionSheet(indexPath: NSIndexPath) {
      let allOptionsActionSheet: UIAlertController = UIAlertController(title:nil, message:nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
      allOptionsActionSheet.addAction(UIAlertAction(title:"Move", style:UIAlertActionStyle.Default, handler:{ action in
      }))
      allOptionsActionSheet.addAction(UIAlertAction(title:"Edit", style:UIAlertActionStyle.Default, handler:{ action in
         self.selectedLocation = self.locations.getLocation(indexPath)
         self.performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
      }))
      allOptionsActionSheet.addAction(UIAlertAction(title:"Delete", style:UIAlertActionStyle.Default, handler:{ action in
         self.deleteLocation(indexPath)
         self.locationsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
      }))
      allOptionsActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
      presentViewController(allOptionsActionSheet, animated:true, completion:nil)
   }
   
   private func presentDeleteActionSheet(indexPath: NSIndexPath) {
      let deleteActionSheet: UIAlertController = UIAlertController(title:nil, message:nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
      deleteActionSheet.addAction(UIAlertAction(title:"Delete", style:UIAlertActionStyle.Default, handler:{ action in
         self.deleteLocation(indexPath)
         self.locationsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
      }))
      deleteActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
      presentViewController(deleteActionSheet, animated:true, completion:nil)
   }
   /* ----End of UIActionSheet functions---- */
}
