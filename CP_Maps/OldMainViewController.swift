//
//  MainViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 5/27/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class OldMainViewController: UIViewController {
   
   @IBOutlet var detailView: UIView!
   
   var currentDetailViewController: UIViewController!
   
   var mapViewController: MapViewController!
   var locationsStoryboard: UIStoryboard!
   var locationsViewController: LocationsViewController!
   var mapView: UIView!
   var locationsTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      //      mainSegmentedControl.addTarget(self, action: "mainSegmentPressed:",
      //         forControlEvents: UIControlEvents.ValueChanged)
      self.instantiate()
      println(mapViewController)
      self.presentDetailController(mapViewController)
      
      //      var navBar = UINavigationBar(frame:
      //         CGRect(x:0, y:0, width:CGRectGetWidth(self.view.frame),
      //         height:standardNavigationBarHeight))
      //      navBar.setItems(["Hello", "World", "!"], animated: false)
      //      navBar.topItem!.title = "Hello"
      //      self.view.addSubview(navBar)
      
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Search,
            target: self, action: "searchBuildingsButtonPressed:")
      self.navigationItem.titleView = self.createSegmentedControl()
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Bookmarks,
            target: self, action: "mapTypesButtonPressed:")
   }
   
   private func instantiate() {
      let mapStoryboard = UIStoryboard(name: "Main", bundle: nil)
      self.mapViewController = mapStoryboard.instantiateViewControllerWithIdentifier("MapViewController")
         as! MapViewController
      
      self.locationsStoryboard = UIStoryboard(name: savedLocationsStoryboard, bundle: nil)
      //      self.locationsViewController = locationsStoryboard.instantiateViewControllerWithIdentifier(chooseBuildingRoomVCStoryboardID)
      //         as! LocationsViewController
   }
   
   private func createSegmentedControl() -> UISegmentedControl {
      let segmentedControl = UISegmentedControl(items: ["Map", "Locations"])
      
      //      segmentedControl.frame = CGRectMake(35, 200, 250, 50)
      segmentedControl.setWidth(standardUISegmentedControlWidth - 5, forSegmentAtIndex: 0)
      segmentedControl.setWidth(standardUISegmentedControlWidth - 5, forSegmentAtIndex: 1)
      
      segmentedControl.addTarget(self, action: "mainSegmentPressed:",
         forControlEvents: UIControlEvents.ValueChanged)
      //      segmentedControl.momentary = true
      
      return segmentedControl
   }
   
   @IBAction func mapTypesButtonPressed(sender: AnyObject) {
      println("left button for maps")
   }
   
   @IBAction func searchBuildingsButtonPressed(sender: AnyObject) {
      let vc = locationsStoryboard.instantiateViewControllerWithIdentifier(chooseBuildingRoomVCStoryboardID) as! ChooseBuildingRoomViewController
      println("before prepare")
      self.showViewController(vc, sender: self)
      self.performSegueWithIdentifier("segueToChooseBuildingFromMapViewController", sender: self)
   }
   
   @IBAction func editButtonPressed(sender: AnyObject) {
      println("left button for location")
   }
   
   @IBAction func addLocationButtonPressed(sender: AnyObject) {
      println("right button for location")
   }
   
   @IBAction func cancelToMainViewController(segue: UIStoryboardSegue) {
      
   }
   
   @IBAction func chooseBuildingForMapViewController(segue:UIStoryboardSegue) {
      //      let navViewController = segue.destinationViewController
      //         as! UINavigationController
      //      let viewController = navViewController.viewControllers.first as!
      
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      //      let viewController = navVC.viewControllers.first as! MapViewController
//      (currentDetailViewController as! MapViewController).showSelectedBuilding(viewController.selectedBuilding)
   }
   
   @IBAction func mainSegmentPressed(sender: AnyObject) {
      let segmentedControl = sender as! UISegmentedControl
      
      switch segmentedControl.selectedSegmentIndex {
      case 0:
         self.swapButtonsForMapView()
         self.swapCurrentControllerWith(mapViewController)
         println("Map")
      case 1:
         self.swapButtonsForLocationsView()
         self.swapCurrentControllerWith(locationsViewController)
         println("Locations")
      default:
         self.showMapView()
      }
   }
   
   private func swapButtonsForMapView() {
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Search,
            target: self, action: "searchBuildingsButtonPressed:")
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Bookmarks,
            target: self, action: "mapTypesButtonPressed:")
   }
   
   private func swapButtonsForLocationsView() {
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Edit,
            target: self, action: "editButtonPressed:")
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Add,
            target: self, action: "addLocationButtonPressed:")
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
      
      //      //TODO: Animations go left and then right
      //      UIView.animateWithDuration(1.3,
      //
      //         //4. Animate the views to create a transition effect
      //         animations: {
      //
      //            //The new controller's view is going to take the position of the current controller's view
      //            viewController.view.frame = self.currentDetailViewController.view.frame
      //
      //            //The current controller's view will be moved outside the window
      //            self.currentDetailViewController.view.frame = CGRectMake(-2000,
      //               0,
      //               self.currentDetailViewController.view.frame.size.width,
      //               self.currentDetailViewController.view.frame.size.width)
      //         },
      //
      //         //5. At the end of the animations we remove the previous view and update the hierarchy.
      //         completion: {
      //            (finished: Bool) in
      //
      //            //Remove the old Detail Controller view from superview
      //            self.currentDetailViewController.view.removeFromSuperview()
      //
      //            //Remove the old Detail controller from the hierarchy
      //            self.currentDetailViewController.removeFromParentViewController()
      //
      //            //Set the new view controller as current
      //            self.currentDetailViewController = viewController
      //            self.currentDetailViewController.didMoveToParentViewController(self)
      //         }
      //      )
      
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
      println(self.detailView)
      let detailFrame = self.detailView.bounds
      
      return detailFrame
   }
   
   private func instantiateUIViews() {
      mapViewController =
         self.storyboard!.instantiateViewControllerWithIdentifier("MapViewController")
         as! MapViewController
      mapView = mapViewController.view as! UIView
      locationsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LocationsViewController")
         as! LocationsViewController
      locationsTableView = locationsViewController.view as! UITableView
      self.view.addSubview(mapView)
      self.view.addSubview(locationsTableView)
   }
   
   private func showMapView() {
      self.view.viewWithTag(mapViewTag)!.hidden = false
      self.view.viewWithTag(locationsTableViewTag)!.hidden = true
   }
   
   private func showLocationsTableView() {
      self.view.viewWithTag(mapViewTag)?.hidden = true
      self.view.viewWithTag(locationsTableViewTag)?.hidden = false
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      if (segue.identifier == segueToChooseBuildingFromMapViewController) {
         //         let navVC = segue.destinationViewController as! UINavigationController
         //         let vc = navVC.viewControllers.first as! ChooseBuildingRoomViewController
         let vc = segue.destinationViewController as! ChooseBuildingRoomViewController
         vc.identifier = segueToChooseBuildingFromMapViewController
      }
   }
   
}
