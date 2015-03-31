//
//  LocationsViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class LocationsViewController: UITableViewController {
   
   var locations: [Location]?
   var indexPath: NSIndexPath?
   var isEditLocation: Bool?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      locations = locationsData

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
      return locations!.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
   -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath)
      as LocationCell
      
      let location = locations![indexPath.row] as Location
      cell.buildingTitleLabel.text = "Building " + location.building.number + " (" + location.building.name + ")"
      if location.room == nil {
         cell.roomTitleLabel.text = ""
      }
      else {
         cell.roomTitleLabel.text = "Room " + location.room!.number
      }
      cell.classTitleLabel.text = location.getCourseDetails()
      return cell
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      
      self.indexPath = indexPath
      performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
   }
   
   override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
      performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      if segue.identifier == editLocationSegueIdentifier {
         let navViewController = segue.destinationViewController as UINavigationController
         let viewController = navViewController.viewControllers.first as AddEditLocationViewController
         viewController.location = locations![indexPath!.row]
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
      let viewController = segue.sourceViewController as AddEditLocationViewController
      
      if isEditLocation == true {
         self.tableView.reloadData() //may need to reload only one table cell
      }
      else {
         //add the new player to the players array
         locations!.append(viewController.location)

         //update the tableView
         let indexPath = NSIndexPath(forRow: locations!.count-1, inSection: 0)
         tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
   }
}
