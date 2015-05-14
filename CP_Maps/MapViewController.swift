//
//  MapViewController.swift
//  Feed Me
//
//  Created by Ron Kliffer on 8/30/14.
//  Copyright (c) 2014 Ron Kliffer. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, TypesTableViewControllerDelegate, CLLocationManagerDelegate {
   
   let TAG = "MapViewController: "
   
   @IBOutlet weak var mapView: GMSMapView!
   @IBOutlet weak var locationTitle: UILabel!
   @IBOutlet weak var floorPlanButton: UIBarButtonItem!
   
   let locationManager = CLLocationManager()
   let locationLibraryAPI = CPMapsLibraryAPI.sharedInstance
   let dataProvider = GoogleDataProvider()
   
   var overlay = GMSGroundOverlay()
   var marker = GMSMarker()
   var line = GMSPolyline(path: nil)
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      if(mapView == nil) {
         NSLog("MapView starts off nil");
      }
      else {
         var startingPosition_UU = CLLocationCoordinate2DMake(35.299776974257, -120.65926909446716)
         mapView.camera = GMSCameraPosition(target: startingPosition_UU, zoom: 15, bearing: 0, viewingAngle: 0)
         
         // initialize overlay
         var southWest = CLLocationCoordinate2DMake(35.295115, -120.6855869)
         var northEast = CLLocationCoordinate2DMake(35.312691, -120.6521129)
         var overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
         var icon = UIImage(named: "PolyMap_Extended.jpg")
         overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
         overlay.bearing = 0
         overlay.map = nil
         
      }
      
      locationManager.delegate = self
      locationManager.requestWhenInUseAuthorization()
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "Types Segue" {
         let navigationController = segue.destinationViewController as! UINavigationController
         let controller = segue.destinationViewController.topViewController as! TypesTableViewController
         controller.delegate = self
      }
      else if segue.identifier == segueToChooseBuildingViewController {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first
            as! ChooseBuildingRoomViewController
         viewController.identifier = chooseBuildingForMapViewController
      }
   }
   
   // Called after selecting a building
   @IBAction func finishedChoosingBuilding(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      let buildingIndexPath = viewController.buildingIndexPath
      let building = locationLibraryAPI.getBuildingAtIndex(buildingIndexPath!.row)
      locationTitle.text = String(building.getNumber()) + " - " + building.getName()
      
      marker.map = nil
      line.map = nil
      
      
      // show directions on a map
      if(building.getLatitude() != 0 && building.getLongtitude() != 0) {
         
         var position = CLLocationCoordinate2DMake(building.getLatitude(), building.getLongtitude())
         marker = GMSMarker(position: position)
         marker.title = building.number + " - " + building.getName()
         marker.snippet = "Floors: " + String(building.getNumberOfFloors())
         marker.infoWindowAnchor = CGPointMake(0.5, 0.1)
         marker.appearAnimation = kGMSMarkerAnimationPop
         marker.map = mapView
         
         // animate to marker
         mapView.animateToLocation(position)
         
         
         // INITIAL MAPPING
         if(locationManager.location != nil) {
               dataProvider.fetchDirectionsFrom(mapView.myLocation.coordinate, to: position) {optionalRoute in
                  if let encodedRoute = optionalRoute {
                     
                     let path = GMSPath(fromEncodedPath: encodedRoute)
                     self.line = GMSPolyline(path: path)
                     
                     self.line.strokeWidth = 4.0
                     self.line.tappable = true
                     self.line.map = self.mapView
                     
                     // 5
                     //self.mapView.selectedMarker = nil
                  }
               }
         }
         else {
            NSLog(TAG + "Location is not shared - cannot map directions")
         }
      }
      
      //enable floor plan button and load images
      floorPlanButton.enabled = true
      
   }
   
   @IBAction func chooseLocation(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! LocationsViewController
      let location = locationLibraryAPI.getLocation(viewController.selectedLocation!)
      locationTitle.text = location.getName()
   }
   
   @IBAction func cancelToMapViewController(segue:UIStoryboardSegue) {
      //      let viewController = segue.sourceViewController as! LocationsViewController
      //      let location = locationLibraryAPI.getLocation(viewController.selectedLocation!.row)
      //      locationTitle.text = location.getBuildingNumber()
   }
   
   @IBAction func clickBackToMaps(segue:UIStoryboardSegue) {
      dismissViewControllerAnimated(true, completion: nil)
      //performSegueWithIdentifier("cancelToMyLocations", sender: self)
   }
   
   // MARK: - Types Controller Delegate
   func typesController(controller: TypesTableViewController, didSelectTypes types: [String]) {
      dismissViewControllerAnimated(true, completion: nil)
   }
   
   @IBAction func mapTypeSegmentPressed(sender: AnyObject) {
      let segmentedControl = sender as! UISegmentedControl
      overlay.map = nil
      
      switch segmentedControl.selectedSegmentIndex {
      case 0:
         mapView.mapType = kGMSTypeNormal
      case 1:
         mapView.mapType = kGMSTypeSatellite
      case 2:
         mapView.mapType = kGMSTypeHybrid
      case 3:
         // overlay cal polys map
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
            
            // make location button move past bottom bar
            mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
         }
         else {
            NSLog(TAG + "MapView is nil");
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
            NSLog(TAG + "MapView is nil");
         }
      }
   }
}

