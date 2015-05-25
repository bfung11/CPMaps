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
   private let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
   
   override init() {
      fetchedResultsController = NSFetchedResultsController()
      super.init()
      fetchedResultsController = getFetchedResultController()
      fetchedResultsController.performFetch(nil)
   }
   
   func getNSFetchedResultsController() -> NSFetchedResultsController {
      return fetchedResultsController
   }
   
   func setDelegate(delegate: NSFetchedResultsControllerDelegate) {
      fetchedResultsController.delegate = delegate
   }
   
   func performFetch(error: NSErrorPointer) {
      fetchedResultsController.performFetch(error)
   }
   
   func getNumberOfSectionsInTableView() -> Int {
      return fetchedResultsController.sections!.count
   }
   
   func getNumberOfRowsInSection(section: Int) -> Int {
      let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
      return sectionInfo.numberOfObjects
   }
   
   func addLocation(name: String?, buildingNumber: String!, roomNumber: String?,
      startTime: String?, endTime: String?, days: String?,
      context: NSManagedObjectContext?) {
         Location.createInManagedObjectContext(name,
            buildingNumber: buildingNumber, roomNumber: roomNumber,
            startTime: startTime, endTime: endTime, days: days,
            insertIntoManagedObjectContext: context)
   }
   
   func getLocation(indexPath: NSIndexPath) -> Location {
      return fetchedResultsController.objectAtIndexPath(indexPath) as! Location
   }
   
   func deleteLocation(location: Location) {
      managedObjectContext?.deleteObject(location)
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
}
