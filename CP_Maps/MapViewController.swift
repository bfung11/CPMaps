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
    else {
      var startingPosition_UU = CLLocationCoordinate2DMake(35.299776974257, -120.65926909446716)
      mapView.camera = GMSCameraPosition(target: startingPosition_UU, zoom: 15, bearing: 0, viewingAngle: 0)
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
    mapView.clear();
   
    switch segmentedControl.selectedSegmentIndex {
      case 0:
        mapView.mapType = kGMSTypeNormal
      case 1:
        mapView.mapType = kGMSTypeSatellite
      case 2:
        mapView.mapType = kGMSTypeHybrid
      case 3:
        //Overlay cal polys map
        var southWest = CLLocationCoordinate2DMake(35.295127282268666, -120.68558692932129)
        var northEast = CLLocationCoordinate2DMake(35.3126913835769, -120.65211296081543)
        var overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
        var icon = UIImage(named: "PolyMap_Extended.jpg")
        var overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
        overlay.bearing = 0
        overlay.map = mapView
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

