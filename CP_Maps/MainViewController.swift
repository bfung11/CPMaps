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
   
   var locationsTableView: UITableView!
   var mapView: UIView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      mainSegmentedControl.addTarget(self, action: "mainSegmentPressed",
         forControlEvents: UIControlEvents.ValueChanged)
      self.instantiateUIViews()
      // Do any additional setup after loading the view.
   }
   
   func mainSegmentPressed(sender: AnyObject) {
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
      let locationsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LocationsTableViewController")
         as! LocationsTableViewController
      locationsTableView = locationsViewController.view as! UITableView
      let mapViewController =
         self.storyboard!.instantiateViewControllerWithIdentifier("MapViewController")
         as! MapViewController
      mapView = mapViewController.view as! UIView
   }
   
   private func showMapView() {
      // !hidden may not work because they may hit the same one twice
      mapView.hidden = true
      locationsTableView.hidden = false
   }
   
   private func showLocationsTableView() {
      // !hidden may not work because they may hit the same one twice
      mapView.hidden = false
      locationsTableView.hidden = true
   }

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
