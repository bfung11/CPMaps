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
   var selectedLocationIndexPath: NSIndexPath!  // location passed as index
   var selectedLocation: Location!
   var name: String?
   var buildings: [Building]!          // holds the data for all buildings
   var buildingIndexPath: NSIndexPath! // selected building as index (of the list of all buildings)
   var selectedRoom: String?           // room from choosing a room or from editing a location with room
   var selectedDays: String?
   var dateFormatter: NSDateFormatter! // optimization; recreating each time is slow
   var startTime: String?
   var endTime: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // set up data source
      locations = CPMapsLibraryAPI.sharedInstance
      buildingIndexPath = nil
      
      // if editing a location
      if self.selectedLocation != nil {
//         setNameLabel()
         setBuildingLabel(locations.getBuilding(self.selectedLocation.getBuildingNumber()))
//         setRoomLabel()
         setDaysLabel()
         if self.selectedLocation.hasRoomNumber() {
            roomTextField.text = "Room " + self.selectedLocation.getRoomNumber()!
            selectedRoom = self.selectedLocation.getRoomNumber()
         }
         if self.selectedLocation.hasName() {
            nameTextField.text = self.selectedLocation.getName()
         }
         self.navigationItem.title = editLocationViewControllerTitle
      }
      else {
         // disable room selection if building not selected
         chooseRoomCell.userInteractionEnabled = false;
         chooseRoomCell.textLabel!.textColor = UIColor.grayColor();
         
         self.navigationItem.title = addLocationViewControllerTitle
      }
      // This may need to be moved in or out depending on whether or not it is edited
      setupDatePickerAndLabel()
      // for some reason, code removes default selection style for days
      chooseDaysCell.selectionStyle = .Default;
   }
   
   @IBAction func cancelToAddEditLocationViewController(segue:UIStoryboardSegue) {
   }
   
   // save selected building and display selected building
   @IBAction func chooseBuildingForAddEditLocationViewController(segue:UIStoryboardSegue) {
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      buildingIndexPath = viewController.buildingIndexPath
      setBuildingLabel(locations.getBuildingAtIndex(buildingIndexPath!))
//      let building = locations.getBuildingAtIndex(buildingIndexPath!)
//      buildingLabel.text = "Building " + building.getNumber() + " (" + building.getName() + ")"
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
   
   /*! Deselects the selected row with UIDatePicker
   
   */
   override func tableView(tableView: UITableView,
      didSelectRowAtIndexPath indexPath: NSIndexPath) {
      if (indexPath.section == sectionWithUIDatePickers
         && indexPath.row < indexOfDaysCell) {
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
   
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      let chooseDaysViewController = segue.sourceViewController as! ChooseDaysViewController
      self.selectedDays = chooseDaysViewController.selectedDays
      daysLabel.text = selectedDays
      if (selectedDays == "") {
         daysLabel.text = "None"
      }
   }
   
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
      
      var shouldPerform = true
      
      // if they have not selected a building, send UIAlertView
      if identifier == saveLocationSegueIdentifer && buildingIndexPath == nil {
         let alert = UIAlertView(title: saveNewLocationTitle,
            message: saveNewLocationMessage, delegate: self,
            cancelButtonTitle: cancelButtonTitleOK)
         alert.show()
         shouldPerform = false
      }
      
      return shouldPerform
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == segueToChooseBuildingViewController {
         let navViewController = segue.destinationViewController
            as! UINavigationController
         let viewController = navViewController.viewControllers.first as! ChooseBuildingRoomViewController
         viewController.identifier = segueToChooseBuildingFromAddEditLocationViewController
         viewController.buildingIndexPath = buildingIndexPath
      }
      if segue.identifier == segueToChooseDaysViewController {
         let viewController = segue.destinationViewController as! ChooseDaysViewController
         viewController.selectedDays = self.selectedDays
      }
      if segue.identifier == saveLocationSegueIdentifer {
         if selectedLocationIndexPath != nil { // if from editing
            // TODO: update building
            let location = locations.getLocation(selectedLocationIndexPath)
//            location.updateRoomNumber(selectedRoom!)
         }
         self.startTime =
            self.dateFormatter.stringFromDate(startTimeDatePicker.date)
         self.endTime =
            self.dateFormatter.stringFromDate(endTimeDatePicker.date)
         self.name = nameTextField.text
      }
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
      self.dateFormatter = NSDateFormatter()
      dateFormatter.dateStyle = .NoStyle
      dateFormatter.timeStyle = .ShortStyle
      
      setupLabelForDatePicker(startTimeLabel)
      setupDatePicker(startTimeDatePicker)
      setupLabelForDatePicker(endTimeLabel)
      setupDatePicker(endTimeDatePicker)
   }
   
   private func setupDatePicker(datePicker: UIDatePicker) {
      datePicker.hidden = true
      datePicker.addTarget(self, action: Selector("updateDatePicker:"),
         forControlEvents: UIControlEvents.ValueChanged)
   }
   
   private func setupLabelForDatePicker(label: UILabel) {
      let defaultDate = NSDate()
      label.text = self.dateFormatter.stringFromDate(defaultDate)
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
   
   /*! Choose a either start or end time date picker
   Assume that it is the first one but check to see if it is the second
   */
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
   
   /* ----Start of Days conversion helper functions---- */
   private func convertToLongName(selectedDays: String) -> String {
      var longName = ""
      let selectedDaysNSString = NSString(string: selectedDays)
      let arr = selectedDaysNSString.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ""))
      
      for day in arr {
         longName += getLongName(day as! String)
      }
      
      return longName
   }
   
   private func getLongName(shortName: String) -> String {
      var longName = "Please select a day"
      
      switch shortName {
      case "Su":
         longName = "Sunday"
      case "M":
         longName = "Monday"
      case "Tu":
         longName = "Tuesday"
      case "W":
         longName = "Wednesday"
      case "Th":
         longName = "Thursday"
      case "F":
         longName = "Friday"
      case "Sa":
         longName = "Saturday"
      default: ()
      }
      
      return longName
   }
   /* ----End of Days conversion helper functions---- */
}
