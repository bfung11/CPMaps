//
//  MapViewTypeTableViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 5/25/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class MapViewTypeTableViewController: UITableViewController {
   
   var mapTypes: [String]!
   var selectedType: String!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      mapTypes = mapTypeData
      self.navigationItem.title = choooseMapTypeTableViewControllerTitle
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(tableView: UITableView,
      numberOfRowsInSection section: Int) -> Int {
         
      return mapTypes.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath
      indexPath: NSIndexPath) -> UITableViewCell {
         
         let cell = self.tableView.dequeueReusableCellWithIdentifier(mapTypeCellReuseIdentifier,
            forIndexPath: indexPath) as! MapViewTypeTableViewCell
         cell.mapTypeLabel.text = mapTypeData[indexPath.row]
         
         if (self.selectedType == mapTypeData[indexPath.row]) {
            cell.accessoryType = .Checkmark
         }
         
         return cell
   }
   
   override func tableView(tableView: UITableView,
      didSelectRowAtIndexPath indexPath: NSIndexPath) {
         
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      let cell = self.tableView.dequeueReusableCellWithIdentifier(mapTypeCellReuseIdentifier,
            forIndexPath: indexPath) as! MapViewTypeTableViewCell
      self.selectedType = mapTypeData[indexPath.row]
      performSegueWithIdentifier(chooseMapType, sender: self)
   }
}
