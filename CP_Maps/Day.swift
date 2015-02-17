//
//  Day.swift
//  CP_Maps
//
//  Created by Brian Fung on 2/16/15.
//  Copyright (c) 2015 Carl-Brian. All rights reserved.
//

import UIKit

class Day: NSObject {
    var name: String
    var value: Int
    
    init(name: String, value: Int) {
        self.name = name
        self.value = value
        super.init()
    }
}