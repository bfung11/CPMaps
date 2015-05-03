//
//  PersistencyManager.swift
//  CP_Maps
//
//  Created by Brian Fung on 4/15/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

// manager that controls all persistent objects
class LocationsPersistencyManager: NSObject {
   var fetchedResultsController: NSFetchedResultsController
   private var locations: [Location]
   private let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
   
   override init() {
      locations = [Location]()
      fetchedResultsController = NSFetchedResultsController()
      super.init()
      fetchedResultsController = getFetchedResultController()
      fetchedResultsController.performFetch(nil)
      locations = fetchLocations()
   }
   
   func getNSFetchedResultsController() -> NSFetchedResultsController {
      return fetchedResultsController
   }
   
   func setDelegate(delegate: NSFetchedResultsControllerDelegate) {
      fetchedResultsController.delegate = delegate
   }
   
   func addLocation(name: String?, buildingNumber: String!, roomNumber: String?, startTime: String?, endTime: String?, days: String?,
      context: NSManagedObjectContext?) {
         Location.createInManagedObjectContext(name, buildingNumber: buildingNumber, roomNumber: roomNumber, startTime: startTime, endTime: endTime, days: days, insertIntoManagedObjectContext: context)
         
         //      see number of entities stored
         //      print("in addLocation")
         //      var fetchRequest = NSFetchRequest(entityName: "Location")
         //      let recordCount = self.managedObjectContext!.countForFetchRequest(fetchRequest, error: nil)
         //      NSLog("user records found: \(recordCount)")
         
         // TODO: should not fetch every time
         locations = fetchLocations()
   }
   
   func getLocation(indexPath: NSIndexPath) -> Location {
      return fetchedResultsController.objectAtIndexPath(indexPath) as! Location
   }
   
   func getNumberOfLocations() -> Int {
      return locations.count
   }
   
   private func getFetchedResultController() -> NSFetchedResultsController {
      return NSFetchedResultsController(fetchRequest: createFetchRequest(),
         managedObjectContext: managedObjectContext!,
         sectionNameKeyPath: nil, cacheName: nil)
   }
   
   private func createFetchRequest() -> NSFetchRequest {
      let fetchRequest = NSFetchRequest(entityName: "Location")
      let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
      fetchRequest.sortDescriptors = [sortDescriptor]
      return fetchRequest
   }
   
   private func fetchLocations() -> [Location] {
      var tempLocations = []
      let fetchRequest = NSFetchRequest(entityName: "Location")
      if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Location] {
         tempLocations = fetchResults
      }
      
      return tempLocations as! [Location]
   }
}
