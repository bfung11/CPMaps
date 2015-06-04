//
//  MapViewController.swift
//  Feed Me
//
//  Created by Ron Kliffer on 8/30/14.
//  Copyright (c) 2014 Ron Kliffer. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
   
   let TAG = "MapViewController: "
   
   @IBOutlet weak var mapView: GMSMapView!
   @IBOutlet weak var locationTitle: UILabel!
   @IBOutlet weak var floorPlansButton: UIBarButtonItem!
   @IBOutlet weak var mapTypeButton: UIButton!
   
   var locationsTableView: UITableView?
   var mainVC: MainViewController!
   
   let locationManager = CLLocationManager()
   let locationLibraryAPI = CPMapsLibraryAPI.sharedInstance
   let dataProvider = GoogleDataProvider()
   
   var overlay = GMSGroundOverlay()
   var marker = GMSMarker()
   var line = GMSPolyline(path: nil)
   var selectedBuilding = Building()
   
   
   /**
    * View Did Load
    */
   override func viewDidLoad() {
      super.viewDidLoad()
      mapView.delegate = self
      
      if(mapView == nil) {
         NSLog("MapView starts off nil");
      }
      else {
         var startingPosition_UU = CLLocationCoordinate2DMake(35.299776974257, -120.65926909446716)
         mapView.camera = GMSCameraPosition(target: startingPosition_UU, zoom: 15, bearing: 0, viewingAngle: 0)
         
         // initialize overlay
         var southWest = CLLocationCoordinate2DMake(35.295115, -120.6864869)
         var northEast = CLLocationCoordinate2DMake(35.313691, -120.6521129)
         var overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
         var icon = UIImage(named: "PolyMap_Extended.jpg")
         overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
         overlay.bearing = 0
         overlay.map = nil
      }
      
      locationManager.delegate = self
      locationManager.requestWhenInUseAuthorization()
      
      mapTypeButton.addTarget(self, action: "mapTypeButtonPressed:", forControlEvents: .TouchUpInside)
      self.floorPlansButton.target = self
      self.floorPlansButton.action = "floorPlansButtonPressed:"
      self.floorPlansButton.enabled = true
   }
   
   @IBAction func floorPlansButtonPressed(sender: AnyObject) {
      let navVC = mainVC.locationsStoryboard.instantiateViewControllerWithIdentifier(chooseBuildingRoomNCStoryboardID) as! UINavigationController
      let vc = mainVC.locationsStoryboard.instantiateViewControllerWithIdentifier(chooseBuildingRoomVCStoryboardID) as! ChooseBuildingRoomViewController
      vc.identifier = chooseBuildingForFloorPlanPSVC
      vc.mainVC = self.mainVC
      navVC.pushViewController(vc, animated: false)
      self.presentViewController(navVC, animated: true, completion: nil)
   }
   
   
   /**
    *
    * Location Manager
    *
    */
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
   

   /**
    *
    * Google Map View Logic
    *
    */
   // Called after selecting a building
   func showSelectedBuilding(building: Building) {
      self.selectedBuilding = building
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
         
         mapToLocation(position)
         mapView.animateToLocation(position)
      }
      
      //enable floor plan button and load images
//      floorPlansButton.enabled = true
      
   }
   
   func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
      self.marker.map = nil
      self.marker = GMSMarker(position: coordinate)
      self.marker.map = self.mapView
      
      //directions and animate
      mapToLocation(coordinate)
      mapView.animateToLocation(coordinate)
   }
   
   //remove marker and directional line from map
   func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
      marker.map = nil
      line.map = nil
      
      locationTitle.text = "CP Maps"
//      floorPlansButton.enabled = false
   }

   // maps to a specified location if current location exists
   func mapToLocation(destinationLocation : CLLocationCoordinate2D) {
      self.line.map = nil
      var currentLocation = locationManager.location
      
      if(currentLocation != nil) {
         dataProvider.fetchDirectionsFrom(mapView.myLocation.coordinate, to: destinationLocation) {optionalRoute in
            if let encodedRoute = optionalRoute {
               
               let path = GMSPath(fromEncodedPath: encodedRoute)
               self.line.path = path
               
               self.line.strokeWidth = 4.0
               self.line.tappable = true
               self.line.zIndex = 1;         // draw over overlay
               self.line.map = self.mapView
            }
         }
      }
      else {
         NSLog(TAG + "Location is not shared - cannot map directions")
      }
   }
   
   
   /**
    *
    * iOS UI Management
    * 
    */
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Building View
      if segue.identifier == chooseBuildingForAddEditLocationVC {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first
            as! ChooseBuildingRoomViewController
         viewController.identifier = segueToChooseBuildingFromMapViewController
      }
      else if segue.identifier == segueToFloorPlanPagedScrollViewController {
         let viewController = segue.destinationViewController
            as! FloorPlanPagedScrollViewController
         viewController.setPages(selectedBuilding)
      }
   }
   
   @IBAction func clickBackToMaps(segue:UIStoryboardSegue) {
      dismissViewControllerAnimated(true, completion: nil)
   }
      
   private func changeMapType(selectedType: Int) {
      overlay.map = nil
      
      switch selectedType {
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
   
   @IBAction func mapTypeButtonPressed(sender: AnyObject) {
      self.presentMapTypeOptionsActionSheet()
   }
   
   private func presentMapOptionsActionSheet() {
      
   }
   
   private func presentMapTypeOptionsActionSheet() {
      let mapTypesActionSheet: UIAlertController = UIAlertController(title:nil, message:nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
      mapTypesActionSheet.addAction(UIAlertAction(title:"Normal", style:UIAlertActionStyle.Default, handler:{ action in
         self.changeMapType(0)
      }))
      mapTypesActionSheet.addAction(UIAlertAction(title:"Satellite", style:UIAlertActionStyle.Default, handler:{ action in
         self.changeMapType(1)
      }))
      mapTypesActionSheet.addAction(UIAlertAction(title:"Hybrid", style:UIAlertActionStyle.Default, handler:{ action in
         self.changeMapType(2)
      }))
      mapTypesActionSheet.addAction(UIAlertAction(title:"Overlay", style:UIAlertActionStyle.Default, handler:{ action in
         self.changeMapType(3)
      }))
      mapTypesActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
      
      presentViewController(mapTypesActionSheet, animated:true, completion:nil)
   }
}

