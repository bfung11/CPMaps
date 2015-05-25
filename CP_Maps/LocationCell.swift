//
//  LocationCell.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/11/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
   @IBOutlet weak var buildingLabel: UILabel!
   @IBOutlet weak var roomLabel: UILabel!
   @IBOutlet weak var locationDetailsLabel: UILabel!
//   
//   var originalCenter = CGPoint()
//   var deleteOnDragRelease = false
//   
//   required init(coder aDecoder: NSCoder) {
//      super.init(coder: aDecoder)
//      var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
//      recognizer.delegate = self
//      addGestureRecognizer(recognizer)
//   }
//   
//   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//      super.init(style: style, reuseIdentifier: reuseIdentifier)
//      var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
//      recognizer.delegate = self
//      addGestureRecognizer(recognizer)
//   }
//   
//   //MARK: - horizontal pan gesture methods
//   func handlePan(recognizer: UIPanGestureRecognizer) {
//      // 1
//      if recognizer.state == .Began {
//         // when the gesture begins, record the current center location
//         originalCenter = center
//      }
//      // 2
//      if recognizer.state == .Changed {
//         let translation = recognizer.translationInView(self)
//         center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
//         // has the user dragged the item far enough to initiate a delete/complete?
//         deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
//      }
//      // 3
//      if recognizer.state == .Ended {
//         // the frame this cell had before user dragged it
//         let originalFrame = CGRect(x: 0, y: frame.origin.y,
//            width: bounds.size.width, height: bounds.size.height)
//         if !deleteOnDragRelease {
//            // if the item is not being deleted, snap back to the original location
//            UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
//         }
//      }
//   }
//   
//   override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//      if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
//         let translation = panGestureRecognizer.translationInView(superview!)
//         if fabs(translation.x) > fabs(translation.y) {
//            return true
//         }
//         return false
//      }
//      return false
//   }
}
