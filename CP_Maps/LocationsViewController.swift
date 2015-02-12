//
//  LocationsViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class LocationsViewController: UITableViewController {
   
   var locations: [Location] = locationsData
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   // MARK: - Table view data source
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return locations.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
   -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath)
      as UITableViewCell

      let location = locations[indexPath.row] as Location
      
      if let locationTitleLabel = cell.viewWithTag(100) as? UILabel {
         locationTitleLabel.text = location.locationTitle
      }
      if let roomNumberLabel = cell.viewWithTag(101) as? UILabel {
         roomNumberLabel.text = location.roomNum
      }
      if let classInfoLabel = cell.viewWithTag(102) as? UILabel {
         classInfoLabel.text = location.classInfo
      }
      return cell
   }
}
