//
//  AddEditLocationViewController.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/14/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class AddEditLocationViewController: UITableViewController {
   @IBOutlet weak var buildingDetail: UILabel!
   @IBOutlet weak var chooseRoomCell: UITableViewCell!
   @IBOutlet weak var roomTextField: UITextField!
   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var daysDetail: UILabel!
   @IBOutlet weak var startTimeLabel: UILabel!
   @IBOutlet weak var startTimeDatePicker: StartEndDatePicker!
   @IBOutlet weak var endTimeLabel: UILabel!
   @IBOutlet weak var endTimeDatePicker: StartEndDatePicker!

   // exclamation point - does not instantiate, but must do so before use
   var selectedLocation: NSIndexPath!  // location passed as index
   var locations: CPMapsLibraryAPI!    // location as sharedInstance
   var buildings: [Building]!          // holds the data for all buildings
   var buildingIndexPath: NSIndexPath! // selected building as index (of the list of all buildings)
   var selectedRoom: String?           // room from choosing a room or from editing a location with room
   var name: String?
   var selectedDays: String?
   var dateFormatter: NSDateFormatter! // optimization; recreating each time is slow
   var startTime: String?
   var endTime: String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // set up data source
      locations = CPMapsLibraryAPI.sharedInstance
      buildingIndexPath = nil
      
      if selectedLocation != nil { // if editing a location, then location must always be passed
         let location = locations.getLocation(selectedLocation)
         let building = locations.getBuildingAtIndex(selectedLocation.row)
         buildingDetail.text = "Building " + building.getNumber() + " (" +
            building.getName() + ")"
         if location.hasRoomNumber() {
            roomTextField.text = "Room " + location.getRoomNumber()
            selectedRoom = location.getRoomNumber()
         }
         if location.hasName() {
            nameTextField.text = location.getName()
         }
         self.selectedDays = location.getDays()
         if location.hasDays() {
//            daysDetail.text = self.getCourseDays() as String
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
   }
   
   private func setupDatePickerAndLabel() {
      self.dateFormatter = NSDateFormatter()
      dateFormatter.dateStyle = .MediumStyle
      dateFormatter.timeStyle = .MediumStyle
      
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
   
   @IBAction func cancelToAddEditLocationViewController(segue:UIStoryboardSegue) {
   }
   
   // save selected building and display selected building
   @IBAction func chooseBuildingForAddEditLocationViewController(segue:UIStoryboardSegue) {
      // save building and display selected building
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      buildingIndexPath = viewController.buildingIndexPath
      let building = locations.getBuildingAtIndex(buildingIndexPath.row)
      buildingDetail.text = "Building " + building.getNumber() + " (" + building.getName() + ")"
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
   
   /*! Hides the cell of the datePicker if not selected by making the height of the cell equal to 0
   */
   override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      // sections and cell numbers start counting at 0
      let firstDatePickerIndex = 1 // constant in code; is the cell index where the datePicker is
      let secondDatePickerIndex = 3
      let kDatePickerCellHeight = 163
      var height = self.tableView.rowHeight
      
      if (indexPath.section == sectionWithUIDatePickers) {
         if (indexPath.row == firstDatePickerIndex ||
            indexPath.row == secondDatePickerIndex) {
               // need to keep inside or else affects regular cells in section
               let datePicker = chooseDatePickerWithIndex(indexPath.row)
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
         let datePicker = chooseDatePickerWithIndex(indexPath.row)
         if (datePicker.isShowing()) {
            self.hideDatePickerCell(datePicker)
         }
         else {
            self.showDatePickerCell(datePicker)
         }
         self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
      }
   }
   
   private func chooseDatePickerWithTag(tag: Int) -> StartEndDatePicker {
      var datePicker = self.startTimeDatePicker
      
      if (tag == startTimeDatePickerTag) {
         datePicker = self.endTimeDatePicker
      }
      
      return datePicker
   }
   
   /*! Choose a either start or end time date picker
   Assume that it is the first one but check to see if it is the second
   */
   private func chooseDatePickerWithIndex(index: Int) -> StartEndDatePicker {
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
   
   // save selected days and display selected days
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      let chooseDaysViewController = segue.sourceViewController as! ChooseDaysViewController
      self.selectedDays = chooseDaysViewController.selectedDays
      daysDetail.text = selectedDays
      if (selectedDays == "") {
         daysDetail.text = "None"
      }
   }
   
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
      
      var shouldPerform = true
      
      // if they have not selected a building
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
         if selectedLocation != nil { // if from editing
            // TODO: update building
            let location = locations.getLocation(selectedLocation)
            location.updateRoomNumber(selectedRoom!)
         }
      }
   }
   
//   /*! Takes all the selected days, puts them into a string separated by commas 
//       and returns it. Used to display the selected days when adding or editing location
//   
//   */
//   private func getCourseDays() -> NSString {
//      var tempTitle = ""
//      var finalTitle: NSString!
//      
//      // add all the days separated by commas
//      for day in selectedDaysAsArray! {
//         tempTitle += day.name + ", "
//      }
//      
//      // delete the final comma added to the string
//      finalTitle = NSString(string: tempTitle)
//      finalTitle = finalTitle.substringToIndex(finalTitle.length - numCharactersToRemoveForFinalLengthOfSelectedDaysString)
//      
//      return finalTitle
//   }
   
   private func convertToShorthand(longName: String) -> String {
      var shortName = "Please select a day"
      
      switch longName {
      case "Sunday":
         shortName = "Su"
      case "Monday":
         shortName = "M"
      case "Tuesday":
         shortName = "Tu"
      case "Wednesday":
         shortName = "W"
      case "Thursday":
         shortName = "Th"
      case "Friday":
         shortName = "F"
      case "Saturday":
         shortName = "Sa"
      default: ()
      }
      
      return shortName
   }
   
   private func convertToLongName(shortName: String) -> String {
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
}
