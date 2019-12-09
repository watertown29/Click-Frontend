//
//  Student.swift
//  CoffeeChats
//
//  Created by daniel pati on 11/22/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import Foundation

struct Student:Codable {
    
    let id: Int
    let name: String
    let netid: String
    let year: String
    let school: String
    let interests: [Interest]
    //later functionality
    //let met_users: [userMet]
    
    

    init(schoolImageName: String, name: String, year: String) {
        self.id = 0
        self.name = name
        self.netid = ""
        self.year = year
        self.school = schoolImageName
        self.interests = []
        //later functionality
        //self.met_users = []
    }
    
}

struct Response: Codable {
    var success: Bool
    var data: [Student]
}

struct Interest: Codable{
    let id: Int
    let interest_name: String
}

struct userMet: Codable{
    let id: Int
    let name: String
    let netid: String
    let year: String
    let school: String
    let interests: [Interest]
}
