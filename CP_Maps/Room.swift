//
//  Room.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/26/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit
import CoreData

class Room: NSObject {
   var number: String!
   
   init(number: String) {
      self.number = number
   }
   
   func getRoomNumber() -> String {
      return self.number
   }
}
