//
//  LocationsViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class LocationsViewController: UITableViewController {
   
   var locations: [Location] = locationsData
   var location: Location?
   var isEditLocation: Bool?
   
   override func viewDidLoad() {
      super.viewDidLoad()

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
      return 1
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return locations.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
   -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath)
      as LocationCell
      
      let location = locations[indexPath.row] as Location
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
      println("here")
      location = locationsData[indexPath.row]

      performSegueWithIdentifier(editLocationSegueIdentifier, sender: self)
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      if segue.identifier == editLocationSegueIdentifier {
         let viewController = segue.destinationViewController as AddEditLocationViewController
         viewController.location = location
         isEditLocation = true
      }
      else {
         isEditLocation = false
      }
      
   }
   
   @IBAction func cancelToLocationsViewController(segue:UIStoryboardSegue) {
      //dismissViewControllerAnimated(true, completion: nil)
      //performSegueWithIdentifier("cancelToMyLocations", sender: self)
   }
   
   @IBAction func saveNewLocation(segue:UIStoryboardSegue) {
      if isEditLocation == true {
         self.tableView.reloadData()
      }
      else {
         let addNewLocationViewController = segue.sourceViewController as AddEditLocationViewController
         
         //add the new player to the players array
         addNewLocationToArray(addNewLocationViewController.location)

         //update the tableView
         let indexPath = NSIndexPath(forRow: locations.count-1, inSection: 0)
         tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
   }
   
   func addNewLocationToArray(location: Location) {
      //question: why do we need both to add?
      locations.append(location)
      locationsData.append(location)
   }
}
