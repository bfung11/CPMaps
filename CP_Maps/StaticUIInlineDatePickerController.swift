//
//  StaticUIInlineDatePickerController.swift
//  CP_Maps
//
//  Created by Brian Fung on 5/17/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class StaticUIInlineDatePickerController: UITableViewController {
   
   @IBOutlet weak var datePicker: UIDatePicker!
   @IBOutlet weak var startTimeLabel: UILabel!
   var datePickerIsShowing: Bool!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
      setupStartTimeLabel()
      self.datePickerIsShowing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }
   
   /* !
   
   */
   private func setupStartTimeLabel() {
      var dateFormatter = NSDateFormatter()
      dateFormatter.dateStyle = .MediumStyle
      dateFormatter.timeStyle = .MediumStyle
      
      let defaultDate = NSDate()
      
      println(dateFormatter.stringFromDate(defaultDate))
      self.startTimeLabel.text = dateFormatter.stringFromDate(defaultDate)
      self.startTimeLabel.tintColor = self.tableView.tintColor
      //      self.selectedBirthday = defaultDate;
   }
   
   /*! Hides the cell of the datePicker if not selected by making the height of the cell equal to 0
   */
   override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      let kDatePickerIndex = 2 // constant in code; is the cell index where the datePicker is
      let kDatePickerCellHeight = 163
      
      var height = self.tableView.rowHeight
      if (indexPath.row == kDatePickerIndex) {
         if (self.datePickerIsShowing!) {
            height = kDatePickerCellHeight as! CGFloat
         }
         else {
            height = 0
         }
      }
      
      return height
   }
   
   /*! Deselects the selected row with UIDatePicker
   
   */
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if (indexPath.row == 1) {
         if (self.datePickerIsShowing!) {
            self.hideDatePickerCell()
         }
         else {
            self.showDatePickerCell()
         }
         self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
      }
   }
   
   private func showDatePickerCell() {
      self.datePickerIsShowing = true
      // Need to call coreData reload?
//      [self.tableView beginUpdates];
//
//      [self.tableView endUpdates];
      self.tableView.beginUpdates()
      self.tableView.endUpdates()
//      self.tableView.reloadData()
      self.datePicker.hidden = false
      self.datePicker.alpha = 0
      UIView.animateWithDuration(0.25, animations: {self.datePicker.alpha = 1.0})
   }
   
   private func hideDatePickerCell() {
      self.datePickerIsShowing = false
      // Need to call coreData reload?
//      [self.tableView beginUpdates];
//
//      [self.tableView endUpdates];
      self.tableView.beginUpdates()
      self.tableView.endUpdates()
//      self.tableView.reloadData()
      UIView.animateWithDuration(0.25, animations: {self.datePicker.alpha = 0}, completion: ({(finished: Bool) in self.datePicker.hidden = true}))
   }

}
