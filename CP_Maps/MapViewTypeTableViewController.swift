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
   
   override func viewDidLoad() {
      super.viewDidLoad()
      mapTypes = mapTypeData
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
}
