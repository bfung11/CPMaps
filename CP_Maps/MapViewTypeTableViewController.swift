//
//  MapViewTypeTableViewController.swift
//  
//
//  Created by Brian Fung on 5/25/15.
//
//

import UIKit

class MapViewTypeTableViewController: TableViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      locations = CPMapsLibraryAPI.sharedInstance
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return fetchedResultsController.getNumberOfSectionsInTableView()
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return fetchedResultsController.getNumberOfRowsInSection(section)
   }
}
