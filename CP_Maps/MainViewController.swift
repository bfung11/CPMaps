//
//  MainViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 5/27/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

   @IBOutlet var detailView: UIView!
   
   var currentDetailViewController: UIViewController!
   
   var segmentedControl: UISegmentedControl!
   var mapStoryboard: UIStoryboard!
   var mapViewController: MapViewController!
   var locationsStoryboard: UIStoryboard!
   var locationsViewController: LocationsViewController!
   var mapView: UIView!
   var locationsTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.instantiateStoryboardsAndControllers()
      self.presentDetailController(mapViewController)
      self.createUISegmentedControl()
      self.createButtonsForMapView()
   }
   
   private func instantiateStoryboardsAndControllers() {
      self.mapStoryboard = UIStoryboard(name: "MapViewController", bundle: nil)
      self.mapViewController = mapStoryboard.instantiateViewControllerWithIdentifier("MapViewController")
         as! MapViewController
      self.mapViewController.mainVC = self
      
      self.locationsStoryboard = UIStoryboard(name: savedLocationsStoryboard, bundle: nil)
      self.locationsViewController = locationsStoryboard.instantiateViewControllerWithIdentifier(savedLocationsTVCStoryboardID) as! LocationsViewController
      self.locationsViewController.mainVC = self
   }
   
   private func createUISegmentedControl() {
      let segmentedControl = UISegmentedControl(items: ["Map", "Locations"])
      
      segmentedControl.setWidth(standardUISegmentedControlWidth - 5, forSegmentAtIndex: 0)
      segmentedControl.setWidth(standardUISegmentedControlWidth - 5, forSegmentAtIndex: 1)
      segmentedControl.addTarget(self, action: "mainSegmentPressed:",
         forControlEvents: UIControlEvents.ValueChanged)
      
      segmentedControl.selectedSegmentIndex = 0
      
      self.segmentedControl = segmentedControl
      self.navigationItem.titleView = self.segmentedControl
   }

   @IBAction func mapTypesButtonPressed(sender: AnyObject) {
      println("left button for maps")
   }
   
   @IBAction func searchBuildingsButtonPressed(sender: AnyObject) {
      let navVC = self.createChooseBuildingRoomViewController(chooseBuildingForMainVC)
      self.presentViewController(navVC, animated: true, completion: nil)
   }
   
   @IBAction func editButtonPressed(sender: AnyObject) {

      println("left button for location")
   }
   
   @IBAction func addLocationButtonPressed(sender: AnyObject) {
      let navVC = self.createAddEditLocationViewController(nil)
      self.presentViewController(navVC, animated: true, completion: nil)
   }
   
   @IBAction func chooseBuildingForMapViewController(segue: UIStoryboardSegue) {
      let vc = segue.sourceViewController as! ChooseBuildingRoomViewController
      mapViewController.selectedBuilding = vc.selectedBuilding
      mapViewController.showSelectedBuilding(vc.selectedBuilding)
   }
   
   @IBAction func chooseBuildingFromMapViewController(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      (currentDetailViewController as! MapViewController).showSelectedBuilding(viewController.selectedBuilding)
   }

   @IBAction func mainSegmentPressed(sender: AnyObject) {
      let segmentedControl = sender as! UISegmentedControl
      
      switch segmentedControl.selectedSegmentIndex {
      case 0:
         self.createButtonsForMapView()
         self.swapCurrentControllerWith(mapViewController)
      case 1:
         self.createButtonsForLocationsView()
         self.swapCurrentControllerWith(locationsViewController)
      default:
         self.showMapView()
      }
   }

   private func presentDetailController(detailVC: UIViewController) {
      
      //0. Remove the current Detail View Controller showed
      if (self.currentDetailViewController != nil) {
         self.removeCurrentDetailViewController()
      }
      
      //1. Add the detail controller as child of the container
      self.addChildViewController(detailVC)
      
      //2. Define the detail controller's view size
      detailVC.view.frame = self.frameForDetailController()
      
      //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
      self.detailView.addSubview(detailVC.view)
      self.currentDetailViewController = detailVC
      
      //4. Complete the add flow calling the function didMoveToParentViewController
      detailVC.didMoveToParentViewController(self)
   }
   
   private func removeCurrentDetailViewController() {
      
      //1. Call the willMoveToParentViewController with nil
      //   This is the last method where your detailViewController can perform some operations before neing removed
      self.currentDetailViewController.willMoveToParentViewController(nil)
      
      //2. Remove the DetailViewController's view from the Container
      self.currentDetailViewController.view.removeFromSuperview()
      
      //3. Update the hierarchy"
      //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
      self.currentDetailViewController.removeFromParentViewController()
   }
   
   private func swapCurrentControllerWith(viewController: UIViewController) {
      
      //1. The current controller is going to be removed
      self.currentDetailViewController.willMoveToParentViewController(nil)
      
      //2. The new controller is a new child of the container
      self.addChildViewController(viewController)
      
      //3. Setup the new controller's frame depending on the animation you want to obtain
      viewController.view.frame = CGRectMake(2000, 0, viewController.view.frame.size.width, viewController.view.frame.size.height)
      
      //3b. Attach the new view to the views hierarchy
      self.detailView.addSubview(viewController.view)
      
      //The new controller's view is going to take the position of the current controller's view
      viewController.view.frame = self.currentDetailViewController.view.frame

      //The current controller's view will be moved outside the window
      self.currentDetailViewController.view.frame = CGRectMake(-2000,
         0,
         self.currentDetailViewController.view.frame.size.width,
         self.currentDetailViewController.view.frame.size.width)

      
      //Remove the old Detail Controller view from superview
      self.currentDetailViewController.view.removeFromSuperview()
      
      //Remove the old Detail controller from the hierarchy
      self.currentDetailViewController.removeFromParentViewController()
      
      //Set the new view controller as current
      self.currentDetailViewController = viewController
      self.currentDetailViewController.didMoveToParentViewController(self)
   }
   
   private func frameForDetailController() -> CGRect {
      let detailFrame = self.detailView.bounds
      
      return detailFrame
   }
   
   private func createButtonsForMapView() {
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Search,
            target: self, action: "searchBuildingsButtonPressed:")
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem()
   }
   
   private func createButtonsForLocationsView() {
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Edit,
            target: self, action: "editButtonPressed:")
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Add,
            target: self, action: "addLocationButtonPressed:")
   }
   
   private func showMapView() {
      self.view.viewWithTag(mapViewTag)!.hidden = false
      self.view.viewWithTag(locationsTableViewTag)!.hidden = true
   }
   
   private func showLocationsTableView() {
      self.view.viewWithTag(mapViewTag)?.hidden = true
      self.view.viewWithTag(locationsTableViewTag)?.hidden = false
   }
   
   func createChooseBuildingRoomViewController(identifier: String) -> UINavigationController {
      let navVC = self.locationsStoryboard.instantiateViewControllerWithIdentifier(chooseBuildingRoomNCStoryboardID) as! UINavigationController
      let vc = self.locationsStoryboard.instantiateViewControllerWithIdentifier(chooseBuildingRoomVCStoryboardID) as! ChooseBuildingRoomViewController
      vc.mainVC = self
      vc.identifier = identifier
      navVC.pushViewController(vc, animated: false)
      
      return navVC
   }
   
   func createAddEditLocationViewController(location: Location?) -> UINavigationController {
      let navVC = self.locationsStoryboard.instantiateViewControllerWithIdentifier(addEditLocationNCStoryboardID) as! UINavigationController
      let vc = self.locationsStoryboard.instantiateViewControllerWithIdentifier(addEditLocationTVCStoryboardID) as! AddEditLocationViewController
      navVC.pushViewController(vc, animated: false)
      vc.selectedLocation = location
      
      return navVC
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if (segue.identifier == segueToChooseBuildingFromMapViewController) {
         let vc = segue.destinationViewController as! ChooseBuildingRoomViewController
         vc.identifier = segueToChooseBuildingFromMapViewController
      }
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
}
