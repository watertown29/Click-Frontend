//
//  Student.swift
//  CoffeeChats
//
//  Created by daniel pati on 11/22/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import Foundation

class Student {
    
    var schoolImageName: String
    var name: String
    var year: String

    init(schoolImageName: String, name: String, year: String) {
        self.schoolImageName = schoolImageName
        self.name = name
        self.year = year
    }
}
