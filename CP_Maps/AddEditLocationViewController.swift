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
   var startTime: String?
   var endTime: String?
   
   
   let kPickerAnimationDuration = 0.40 // duration for the animation to slide the date picker into view
   let kDatePickerTag           = 99   // view tag identifiying the date picker view
   
   let kTitleKey = "title" // key for obtaining the data source item's title
   let kDateKey  = "date"  // key for obtaining the data source item's date value
   
   // keep track of which rows have date cells
   let kDateStartRow = 1
   let kDateEndRow   = 2
   
   let kDateCellID       = "dateCell";       // the cells with the start or end date
   let kDatePickerCellID = "datePickerCell"; // the cell containing the date picker
   let kOtherCellID      = "otherCell";      // the remaining cells at the end
   
   var dataArray: [[String: AnyObject]] = []
   var dateFormatter = NSDateFormatter()
   
   // keep track which indexPath points to the cell with UIDatePicker
   var datePickerIndexPath: NSIndexPath?
   
   var pickerCellRowHeight: CGFloat = 216
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // setup our data source
      let itemOne = [kTitleKey : "Tap a cell to change its date:"]
      let itemTwo = [kTitleKey : "Start Date", kDateKey : NSDate()]
      let itemThree = [kTitleKey : "End Date", kDateKey : NSDate()]
      let itemFour = [kTitleKey : "(other item1)"]
      let itemFive = [kTitleKey : "(other item2)"]
      dataArray = [itemOne, itemTwo, itemThree, itemFour, itemFive]
      
      dateFormatter.dateStyle = .ShortStyle // show short-style date format
      dateFormatter.timeStyle = .ShortStyle
      
      // if the local changes while in the background, we need to be notified so we can update the date
      // format in the table view cells
      //
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "localeChanged:", name: NSCurrentLocaleDidChangeNotification, object: nil)
      
      
      
      
      
      
      
      
      
      
      
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
//      selectedDays = chooseDaysViewController.selectedDays // can be empty, not nil
      
      // display selected days
      daysDetail.text = "None"
      if !selectedDaysAsArray!.isEmpty {
         daysDetail.text = self.getCourseDays() as String
      }
   }
   
   // MARK: - Locale
   
   /*! Responds to region format or locale changes.
   */
   func localeChanged(notif: NSNotification) {
      // the user changed the locale (region format) in Settings, so we are notified here to
      // update the date format in the table view cells
      //
      tableView.reloadData()
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
}
