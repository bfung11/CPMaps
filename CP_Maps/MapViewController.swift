//
//  MapViewController.swift
//  Feed Me
//
//  Created by Ron Kliffer on 8/30/14.
//  Copyright (c) 2014 Ron Kliffer. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, TypesTableViewControllerDelegate, CLLocationManagerDelegate {
  
  @IBOutlet weak var mapView: GMSMapView!
  var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
  
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
   
    if(mapView == nil) {
      NSLog("MapView starts off nil");
    }
   
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "Types Segue" {
      let navigationController = segue.destinationViewController as UINavigationController
      let controller = segue.destinationViewController.topViewController as TypesTableViewController
      controller.selectedTypes = searchedTypes
      controller.delegate = self
    }
  }
   
   @IBAction func clickBackToMaps(segue:UIStoryboardSegue) {
      dismissViewControllerAnimated(true, completion: nil)
      //performSegueWithIdentifier("cancelToMyLocations", sender: self)
   }
  
  // MARK: - Types Controller Delegate
  func typesController(controller: TypesTableViewController, didSelectTypes types: [String]) {
    searchedTypes = sorted(controller.selectedTypes)
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func mapTypeSegmentPressed(sender: AnyObject) {
    let segmentedControl = sender as UISegmentedControl
    switch segmentedControl.selectedSegmentIndex {
      case 0:
        mapView.mapType = kGMSTypeNormal
      case 1:
        mapView.mapType = kGMSTypeSatellite
      case 2:
        mapView.mapType = kGMSTypeHybrid
      default:
        mapView.mapType = mapView.mapType
    }
  }
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedWhenInUse {
 
      locationManager.startUpdatingLocation()
 
      if(mapView != nil) {
         mapView.myLocationEnabled = true
         mapView.settings.myLocationButton = true
      }
      else {
         NSLog("MapView is nil");
      }
    }
  }
 
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    if let location = locations.first as? CLLocation {
 
 // bldg 14
 // lat: 35.300226
 // long: -120.662171
      if(mapView != nil) {
         mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
         locationManager.stopUpdatingLocation()
      }
      else {
         NSLog("MapView is nil");
      }
    }
  }
}

