//
//  ChooseBuildingRoomViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//
//  Description: Abstract class to choose building and choose room
//

import UIKit

class ChooseBuildingRoomViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
   var identifier: String?      // determines whether to display building or room data
   var api: CPMapsLibraryAPI!       // building data or room data
   var filteredBuildings: [Building] = []
   var selectedBuilding: Building!
   var destinationStoryboard: UIStoryboard?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      api = CPMapsLibraryAPI.sharedInstance
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Cancel,
            target: self, action: "cancelButtonPressed:")
      if identifier == chooseBuildingForFloorPlanPSVC {
         self.navigationItem.title = chooseFloorPlansTitle
      }
      else {
         self.navigationItem.title = chooseBuildingsTitle
   
      }
   }
   
   @IBAction func cancelButtonPressed(sender: AnyObject) {
      if (identifier == chooseBuildingForMainVC ||
         identifier == chooseBuildingForFloorPlanPSVC) {
         self.dismissViewControllerAnimated(true, completion: nil)
      }
      else if identifier == chooseBuildingForAddEditLocationVC {
         self.performSegueWithIdentifier(cancelToAddEditLocationViewController, sender: self)
      }
   }
   
   @IBAction func chooseBuildingFromMapViewController(sender: AnyObject) {
      
   }
   
   @IBAction func chooseBuildingFromMainViewController(sender: AnyObject) {
      self.identifier = chooseBuildingForMainVC
   }
   
   @IBAction func cancelFromChooseBuildingRoomViewController(sender: AnyObject) {
      if identifier == chooseBuildingForAddEditLocationVC {
         performSegueWithIdentifier(cancelToAddEditLocationViewController, sender: self)
      }
      else if identifier == segueToChooseBuildingFromMapViewController {
         performSegueWithIdentifier(cancelToMapViewController, sender: self)
      }
   }
   
   
   //SEARCHING
   func filterContentForSearchText(searchText: String) {
      // Filter the array using the filter method
      self.filteredBuildings = api.filterBuildings(searchText)
   }
   
   func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
      self.filterContentForSearchText(searchString)
      return true
   }
   
   func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
      self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
      return true
   }
   
   
   // Table view functions
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInChooseBuildingRoomViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if tableView == self.searchDisplayController!.searchResultsTableView {
         return self.filteredBuildings.count
      } else {
         return api.getNumberOfBuildings()
      }
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell: UITableViewCell?
      var building : Building
      
      //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
      cell = tableView.dequeueReusableCellWithIdentifier("BuildingRoomCell", forIndexPath: indexPath) as? UITableViewCell
      
      // Check to see whether the normal table or search results table is being displayed and set the building object from the appropriate array
      if tableView == self.searchDisplayController!.searchResultsTableView {
         building = filteredBuildings[indexPath.row]
      } else {
         building = api.getBuildingAtIndex(indexPath) // for readability
      }
      
      // display buildings in UI
      cell!.textLabel?.text = building.getNumber() + " - " + building.getName()
      cell!.accessoryType = .None //prevents random buildings from having checkmarks
      
      // if there is a selected building, put a checkmark next to the selected building
      if self.selectedBuilding != nil && selectedBuilding.getName() == building.getName() {
         cell!.accessoryType = .Checkmark
      }
      
      return cell!
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      self.selectedBuilding = api.getBuildingAtIndex(indexPath)
      
      // UI management
      if identifier == chooseBuildingForMainVC {
         performSegueWithIdentifier(chooseBuildingForMapViewController, sender: self)
      }
      else if identifier == chooseBuildingForFloorPlanPSVC {
         let navVC = destinationStoryboard!.instantiateViewControllerWithIdentifier(floorPlansNCStoryboardID) as! UINavigationController
         let vc = destinationStoryboard!.instantiateViewControllerWithIdentifier(floorPlansPSVCStoryboardID) as! FloorPlanPagedScrollViewController
         navVC.pushViewController(vc, animated: false)
         vc.setPages(self.selectedBuilding)
         self.presentViewController(navVC, animated: true, completion: nil)
      }
      else if identifier == chooseBuildingForAddEditLocationVC {
         performSegueWithIdentifier(chooseBuildingForAddEditLocationVC, sender: self)
      }

   }
}
