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
      cell.buildingTitleLabel.text = location.buildingTitle
      cell.roomTitleLabel.text = location.roomTitle
      cell.classTitleLabel.text = location.classTitle
      return cell
   }
   
   @IBAction func cancelToLocationsViewController(segue:UIStoryboardSegue) {
      //dismissViewControllerAnimated(true, completion: nil)
      //performSegueWithIdentifier("cancelToMyLocations", sender: self)
   }
   
   @IBAction func saveNewLocation(segue:UIStoryboardSegue) {
      let addNewLocationViewController = segue.sourceViewController as AddNewLocationViewController
      
      //add the new player to the players array
      addNewLocationToArray(addNewLocationViewController.location)

      //update the tableView
      let indexPath = NSIndexPath(forRow: locations.count-1, inSection: 0)
      tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
   }
   
   func addNewLocationToArray(location: Location){
      //question: why do we need both to add?
      locations.append(location)
      locationsData.append(location)
   }
}
