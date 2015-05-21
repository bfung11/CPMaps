//
//  StartEndDatePicker.swift
//  CP_Maps
//
//  Created by Brian Fung on 5/21/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class StartEndDatePicker: UIDatePicker {
   private var isDatePickerShowing: Bool!
   
   required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      isDatePickerShowing = false
   }
   
   func isShowing() -> Bool {
      return isDatePickerShowing
   }
   
   func show() {
      self.isDatePickerShowing = true
      self.hidden = false
      self.alpha = 0
      UIView.animateWithDuration(0.25, animations: {self.alpha = 1.0})
   }
   
   func hide() {
      self.isDatePickerShowing = false
      UIView.animateWithDuration(0.25, animations: {self.alpha = 0},
         completion: ({(finished: Bool) in self.hidden = true}))
   }
}
