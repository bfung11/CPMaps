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
   @IBOutlet weak var datePicker: UIDatePicker!
   
   // exclamation point - does not instantiate, but must do so before use
   var selectedLocation: NSIndexPath!  // location passed as index
   var locations: CPMapsLibraryAPI!    // location as sharedInstance
   var buildings: [Building]!          // holds the data for all buildings
   var buildingIndexPath: NSIndexPath! // selected building as index (of the list of all buildings)
   var selectedRoom: String?           // room from choosing a room or from editing a location with room
   var name: String?
   var selectedDays: String?
   var selectedDaysAsArray: [Day]?
   var datePickerIsShowing: Bool!
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
            daysDetail.text = self.getCourseDays() as String
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
      setupStartTimeLabel()
      self.datePickerIsShowing = false
   }
   
   @IBAction func cancelToAddEditViewController(segue:UIStoryboardSegue) {
   }
   
   // save selected building and display selected building
   @IBAction func saveBuilding(segue:UIStoryboardSegue) {
      // save building and display selected building
      let viewController = segue.sourceViewController as! ChooseBuildingRoomViewController
      buildingIndexPath = viewController.buildingIndexPath
      let building = locations.getBuildingAtIndex(buildingIndexPath.row)
      buildingDetail.text = "Building " + building.getNumber() + " (" + building.getName() + ")"
   }
   
   // save selected days and display selected days
   @IBAction func saveDays(segue:UIStoryboardSegue) {
      // get selected days from view controller
      let chooseDaysViewController = segue.sourceViewController as! ChooseDaysViewController
      selectedDaysAsArray = chooseDaysViewController.selectedDays // can be empty, not nil
      // display selected days
      daysDetail.text = "None"
      if !selectedDaysAsArray!.isEmpty {
         daysDetail.text = self.getCourseDays() as String
      }
   }
   
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
      
      var shouldPerform = true
      
      // if they have not selected a building
      if identifier == saveLocationSegueIdentifer && buildingIndexPath == nil {          let alert =
         UIAlertView(title: saveNewLocationTitle, message: saveNewLocationMessage, delegate: self, cancelButtonTitle: cancelButtonTitleOK)
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
         viewController.identifier = chooseBuildingForAddEditViewController
         viewController.buildingIndexPath = buildingIndexPath
      }
      if segue.identifier == segueToChooseDaysViewController {
         let viewController = segue.destinationViewController as! ChooseDaysViewController
         viewController.selectedDays = selectedDaysAsArray
      }
      if segue.identifier == saveLocationSegueIdentifer {
         if selectedLocation != nil { // if from editing
            // TODO: update building
            let location = locations.getLocation(selectedLocation)
            location.updateRoomNumber(selectedRoom!)
         }
      }
   }
   
   /*! Takes all the selected days, puts them into a string separated by commas 
       and returns it. Used to display the selected days when adding or editing location
   
   */
   private func getCourseDays() -> NSString {
      var tempTitle = ""
      var finalTitle: NSString!
      
      // add all the days separated by commas
      for day in selectedDaysAsArray! {
         tempTitle += day.name + ", "
      }
      
      // delete the final comma added to the string
      finalTitle = NSString(string: tempTitle)
      finalTitle = finalTitle.substringToIndex(finalTitle.length - numCharactersToRemoveForFinalLengthOfSelectedDaysString)
      
      return finalTitle
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
      // sections and cell numbers start counting at 0
      let kDatePickerIndex = 1 // constant in code; is the cell index where the datePicker is
      let kDatePickerCellHeight = 163
      
      var height = self.tableView.rowHeight
//      print("section ")
//      println(indexPath.section)
//      print(" ")
//      if (indexPath.section == 2) {
//         println(indexPath.row)
//      }
      if (indexPath.section == 2 && indexPath.row == kDatePickerIndex) {
         if (self.datePickerIsShowing!) {
            height = CGFloat(kDatePickerCellHeight)
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
      if (indexPath.section == 2 && indexPath.row == 0) {
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
//      Need to call coreData reload?
//      [self.tableView beginUpdates];
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
//       Need to call coreData reload?
//      [self.tableView beginUpdates];
//      [self.tableView endUpdates];
      self.tableView.beginUpdates()
      self.tableView.endUpdates()
//      self.tableView.reloadData()
//      self.datePicker.hidden = true
      UIView.animateWithDuration(0.25, animations: {self.datePicker.alpha = 0}, completion: ({(finished: Bool) in self.datePicker.hidden = true}))
   }
}
