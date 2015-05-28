//
//  MainViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 5/27/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

   @IBOutlet weak var mainSegmentedControl: UISegmentedControl!
   
   var mapViewController: UIViewController!
   var locationsViewController: UITableViewController!
   var mapView: UIView!
   var locationsTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      mainSegmentedControl.addTarget(self, action: "mainSegmentPressed:",
         forControlEvents: UIControlEvents.ValueChanged)
//      let vc = self.viewControllerForSegmentIndex(self.mainSegmentedControl.selectedSegmentIndex)
//      self.addChildViewController(vc)
//      vc.view.frame = self.view.bounds;
//      self.view.addSubview(vc.view)
//      self.currentViewController = vc
      
      // probably should add into container controller
      self.instantiateUIViews()
      // Do any additional setup after loading the view.
   }
   
   @IBAction func mainSegmentPressed(sender: AnyObject) {
      let segmentedControl = sender as! UISegmentedControl
      
      switch segmentedControl.selectedSegmentIndex {
      case 0:
         self.showMapView()
         println("Map")
      case 1:
         self.showLocationsTableView()
         println("Locations")
      default:
         self.showMapView()
      }
   }

   private func instantiateUIViews() {
      mapViewController =
      self.storyboard!.instantiateViewControllerWithIdentifier("MapViewController")
         as! MapViewController
      mapView = mapViewController.view as! UIView
      locationsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LocationsTableViewController")
         as! LocationsTableViewController
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
   
//   private func initializeMapView() -> UIView {
//      let mapViewController =
//      self.storyboard!.instantiateViewControllerWithIdentifier("MapViewController")
//         as! MapViewController
//      return mapViewController.view
//   }
//   
//   private func initializeLocationsView() -> UIView {
//      let locationsViewController =
//         self.storyboard!.instantiateViewControllerWithIdentifier("LocationsTableViewController")
//         as! LocationsTableViewController
//      return locationsViewController.view
//   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
