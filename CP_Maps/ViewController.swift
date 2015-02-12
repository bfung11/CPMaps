//
//  ViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   @IBOutlet weak var tableView: UITableView!
   var locations = [Location]();
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.dataSource = self
      tableView.delegate = self
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
      
      // Do any additional setup after loading the view.
      if locations.count > 0 {
         return
      }
      locations.append(Location(location: "feed the cat"))
      locations.append(Location(location: "buy eggs"))
      locations.append(Location(location: "watch WWDC videos"))
      locations.append(Location(location: "rule the Web"))
      locations.append(Location(location: "buy a new iPhone"))
      locations.append(Location(location: "darn holes in socks"))
      locations.append(Location(location: "write this tutorial"))
      locations.append(Location(location: "master Swift"))
      locations.append(Location(location: "learn to draw"))
      locations.append(Location(location: "get more exercise"))
      locations.append(Location(location: "catch up with Mom"))
      locations.append(Location(location: "get a hair cut"))
   }
   
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return locations.count
   }
   
   func tableView(tableView: UITableView,
      cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCellWithIdentifier("cell",
            forIndexPath: indexPath) as UITableViewCell
         let item = locations[indexPath.row]
         cell.textLabel?.text = item.location
         return cell
   }
   /*
   override func didReceiveMemoryWarning() {
   super.didReceiveMemoryWarning()
   // Dispose of any resources that can be recreated.
   }
   */

   /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
