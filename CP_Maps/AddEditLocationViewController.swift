//
//  AddEditLocationViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class AddEditLocationViewController: UITableViewController {
   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var buildingLabel: UILabel!
   @IBOutlet weak var chooseRoomCell: UITableViewCell!
   @IBOutlet weak var roomTextField: UITextField!
   @IBOutlet weak var startTimeLabel: UILabel!
   @IBOutlet weak var startTimeDatePicker: StartEndDatePicker!
   @IBOutlet weak var endTimeLabel: UILabel!
   @IBOutlet weak var endTimeDatePicker: StartEndDatePicker!
   @IBOutlet weak var chooseDaysCell: UITableViewCell!
   @IBOutlet weak var daysLabel: UILabel!
   
   // exclamation point - does not instantiate, but must do so before use
   var locations: CPMapsLibraryAPI!    // location as sharedInstance
   var selectedLocation: Location!
   var name: String?
   var selectedBuilding: Building!
   var selectedRoom: String?           // room from choosing a room or from editing a location with room
   var dateFormatter: NSDateFormatter! // optimization; recreating each time is slow
   var startTime: String?
   var endTime: String?
   var selectedDays: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      locations = CPMapsLibraryAPI.sharedInstance
      if (self.isEditing() == true) {
         setNameLabel()
         self.selectedBuilding = locations.getBuilding(self.selectedLocation.getBuildingNumber())
         setBuildingLabel(selectedBuilding)
         setRoomLabel()
         self.selectedDays = self.selectedLocation.getDays()
         setDaysLabel()
         self.navigationItem.title = editLocationViewControllerTitle
      }
      else {
         // disable room selection if building not selected
         chooseRoomCell.userInteractionEnabled = false;
         chooseRoomCell.textLabel!.textColor = UIColor.grayColor();
         
         self.navigationItem.title = addLocationViewControllerTitle
      }
      self.setupNavigationItems()
      setupDatePickerAndLabel()
      // for some reason, code removes default selection style for days
      chooseDaysCell.selectionStyle = .Default;
   }
   
   private func setupNavigationItems() {
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Cancel,
            target: self, action: "cancelButtonPressed:")
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Save,
            target: self, action: "saveButtonPressed:")
   }
   
   @IBAction func cancelButtonPressed(sender: AnyObject) {
      self.dismissViewControllerAnimated(true, completion: nil)
//      self.performSegueWithIdentifier(cancelToLocationsTVC, sender: self)
   }
   
   @IBAction func saveButtonPressed(sender: AnyObject) {
      self.performSegueWithIdentifier(saveLocation, sender: self)
   }
   
   /*! Hides the cell of the datePicker if not selected
   by making the height of the cell equal to 0
   
   */
   override func tableView(tableView: UITableView,
      heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         
         // sections and cell numbers start counting at 0
         let firstDatePickerIndex = 1 // cell index where the datePicker is
         let secondDatePickerIndex = 3
         let kDatePickerCellHeight = 163
         var height = self.tableView.rowHeight
         
         if (indexPath.section == sectionWithUIDatePickers) {
            if (indexPath.row == firstDatePickerIndex ||
               indexPath.row == secondDatePickerIndex) {
                  // need to keep inside or else affects regular cells in section
                  let datePicker = chooseDatePickerUsingIndex(indexPath.row)
                  if (datePicker.isShowing()) {
                     height = CGFloat(kDatePickerCellHeight)
                  }
                  else {
                     height = 0
                  }
            }
         }
         
         return height
   }
   
   override func tableView(tableView: UITableView,
      didSelectRowAtIndexPath indexPath: NSIndexPath) {
         if (indexPath.section == sectionWithUIDatePickers) {
            if (indexPath.row < indexOfDaysCell) {
               let datePicker = chooseDatePickerUsingIndex(indexPath.row)
               if (datePicker.isShowing()) {
                  self.hideDatePickerCell(datePicker)
               }
               else {
                  self.showDatePickerCell(datePicker)
               }
               self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
         }
   }
   
   /*! Save display selected building */
   @IBAction func chooseBuildingForAddEditLocationViewController(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      self.selectedBuilding = viewController.selectedBuilding
      setBuildingLabel(self.selectedBuilding)
   }
   
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      let chooseDaysViewController = segue.sourceViewController as! ChooseDaysViewController
      self.selectedDays = chooseDaysViewController.selectedDays
      daysLabel.text = selectedDays
      if (selectedDays == "") {
         daysLabel.text = "None"
      }
   }
   
   @IBAction func cancelToAddEditLocationViewController(segue:UIStoryboardSegue) {
   }
   
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
      
      var shouldPerform = true
      
      // if they have not selected a building, send UIAlertView
      if identifier == saveLocationSegueIdentifer && selectedBuilding == nil {
         let alert = UIAlertView(title: saveNewLocationTitle,
            message: saveNewLocationMessage, delegate: self,
            cancelButtonTitle: cancelButtonTitleOK)
         alert.show()
         shouldPerform = false
      }
      
      return shouldPerform
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      println("prepare for segue")
      println(segue.identifier)
      println(cancelToLocationsTVC)
      if segue.identifier == chooseBuildingForAddEditLocationVC {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first as! ChooseBuildingRoomViewController
         viewController.identifier = chooseBuildingForAddEditLocationVC
         println(viewController.identifier)
         viewController.selectedBuilding = self.selectedBuilding
      }
      else if segue.identifier == chooseDays {
         let viewController = segue.destinationViewController as! ChooseDaysViewController
         viewController.selectedDays = self.selectedDays
      }
      else if segue.identifier == saveLocationSegueIdentifer {
         self.name = self.nameTextField.text
         self.selectedRoom = "Please select a room"
         self.startTime =
            self.dateFormatter.stringFromDate(startTimeDatePicker.date)
         self.endTime =
            self.dateFormatter.stringFromDate(endTimeDatePicker.date)
      }
   }
   
   private func isEditing() -> Bool {
      return self.selectedLocation != nil
   }
   
   /* ----Start of setting label functions---- */
   private func setNameLabel() {
      if self.selectedLocation.hasName() {
         nameTextField.text = self.selectedLocation.getName()
      }
   }
   
   private func setBuildingLabel(building: Building) {
      buildingLabel.text = "Building " + building.getNumber() + " (" +
         building.getName() + ")"
   }
   
   private func setRoomLabel() {
      if self.selectedLocation.hasRoomNumber() {
         roomTextField.text = "Room " + self.selectedLocation.getRoomNumber()!
         selectedRoom = self.selectedLocation.getRoomNumber()
      }
   }
   
   private func setDaysLabel() {
      if self.selectedLocation.hasDays() {
         self.daysLabel.text = self.selectedLocation.getDays()
      }
   }
   /* ----End of setting label functions---- */
   
   /* ----Start of DatePicker helper functions---- */
   private func setupDatePickerAndLabel() {
      var startTime = ""
      var endTime = ""
      var startDate: NSDate
      var endDate: NSDate
      
      self.dateFormatter = NSDateFormatter()
      dateFormatter.dateStyle = .NoStyle
      dateFormatter.timeStyle = .ShortStyle
      
      if (self.isEditing() == true) {
         startTime = self.selectedLocation.getStartTime()!
         endTime = self.selectedLocation.getEndTime()!
      }
      else {
         startTime = self.dateFormatter.stringFromDate(NSDate())
         endTime = self.dateFormatter.stringFromDate(NSDate())
      }
      
      startDate = self.dateFormatter.dateFromString(startTime)!
      endDate = self.dateFormatter.dateFromString(endTime)!
      
      setupLabelForDatePicker(startTimeLabel, time: startTime)
      setupDatePicker(startTimeDatePicker, date: startDate)
      setupLabelForDatePicker(endTimeLabel, time: endTime)
      setupDatePicker(endTimeDatePicker, date: endDate)
   }
   
   private func setupDatePicker(datePicker: UIDatePicker, date: NSDate) {
      datePicker.hidden = true
      datePicker.addTarget(self, action: Selector("updateDatePicker:"),
         forControlEvents: UIControlEvents.ValueChanged)
      datePicker.setDate(date, animated: false)
   }
   
   private func setupLabelForDatePicker(label: UILabel, time: String) {
      label.text = time
      label.tintColor = self.tableView.tintColor
   }
   
   func updateDatePicker(datePicker: UIDatePicker) {
      var strDate = self.dateFormatter.stringFromDate(datePicker.date)
      if (datePicker.tag == startTimeDatePickerTag) {
         self.startTimeLabel.text = strDate
      }
      else if (datePicker.tag == endTimeDatePickerTag) {
         self.endTimeLabel.text = strDate
      }
   }
   
   private func chooseDatePickerUsingTag(tag: Int) -> StartEndDatePicker {
      var datePicker = self.startTimeDatePicker
      
      if (tag == startTimeDatePickerTag) {
         datePicker = self.endTimeDatePicker
      }
      
      return datePicker
   }
   
   private func chooseDatePickerUsingIndex(index: Int) -> StartEndDatePicker {
      let secondDateCellIndex = 2
      let secondDatePickerCellIndex = 3
      var datePicker = self.startTimeDatePicker
      
      if (index == secondDateCellIndex || index == secondDatePickerCellIndex) {
         datePicker = self.endTimeDatePicker
      }
      
      return datePicker
   }
   
   private func showDatePickerCell(datePicker: StartEndDatePicker) {
      datePicker.reverseIsShowing()
      self.tableView.beginUpdates() // if use tableView.reloadData() - no animation
      self.tableView.endUpdates()
      datePicker.show()
   }
   
   private func hideDatePickerCell(datePicker: StartEndDatePicker) {
      datePicker.reverseIsShowing()
      self.tableView.beginUpdates() // if use tableView.reloadData() - no animation
      self.tableView.endUpdates()
      datePicker.hide()
   }
   /* ----End of DatePicker helper functions---- */
}
