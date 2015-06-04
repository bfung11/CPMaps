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

class ChooseBuildingRoomViewController: UITableViewController {
   var mainVC: MainViewController?
   var identifier: String?      // determines whether to display building or room data
   var data: CPMapsLibraryAPI!       // building data or room data
   var selectedBuilding: Building!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      data = CPMapsLibraryAPI.sharedInstance
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
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return numberOfSectionsInChooseBuildingRoomViewController
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.getNumberOfBuildings()
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell: UITableViewCell?
      var building = data.getBuildingAtIndex(indexPath) // for readability
      
      // display buildings
      cell = tableView.dequeueReusableCellWithIdentifier("BuildingRoomCell", forIndexPath: indexPath) as? UITableViewCell
      cell!.textLabel?.text = building.getNumber() + " - " + building.getName()
      cell!.accessoryType = .None //prevents random buildings from having checkmarks
      
      // if there is a selected building, put a checkmark next to the selected building
      if self.selectedBuilding != nil && selectedBuilding.getName() == building.getName() {
         cell!.accessoryType = .Checkmark
      }
      
      return cell!
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      self.selectedBuilding = data.getBuildingAtIndex(indexPath)
      
      if identifier == chooseBuildingForMainVC {
         performSegueWithIdentifier(chooseBuildingForMapViewController, sender: self)
      }
      else if identifier == chooseBuildingForFloorPlanPSVC {
         let navVC = mainVC?.mapStoryboard.instantiateViewControllerWithIdentifier(floorPlansNCStoryboardID) as! UINavigationController
         let vc = mainVC?.mapStoryboard.instantiateViewControllerWithIdentifier(floorPlansPSVCStoryboardID) as! FloorPlanPagedScrollViewController
         navVC.pushViewController(vc, animated: false)

         vc.mainVC = mainVC
         vc.setPages(self.selectedBuilding)

         self.presentViewController(navVC, animated: true, completion: nil)
      }
      else if identifier == chooseBuildingForAddEditLocationVC {
         performSegueWithIdentifier(chooseBuildingForAddEditLocationVC, sender: self)
      }

   }
}
