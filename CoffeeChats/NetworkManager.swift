//
//  NetworkManager.swift
//  CoffeeChats
//
//  Created by daniel pati on 12/8/19.
//  Copyright © 2019 danielpati. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON


class NetworkManager {
    
    //get all matches for user
    static func getAllMatches(netid: String, _ didGetStudents: @escaping ([Student]) -> Void) {
        let getMatchesURL = "http://35.237.123.122/api/user/friends/" + netid.lowercased() + "/"
        Alamofire.request(getMatchesURL, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let respData):
                let jsonDecoder = JSONDecoder()
                
                if let studentData = try? jsonDecoder.decode(Response.self, from: respData) {
                    
                    let data = studentData.data
                    didGetStudents(data)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    //get all users
    private static let getAllURL = "http://35.237.123.122/api/user/all/"
    
    static func getAllUsers(_ didGetStudents: @escaping ([Student]) -> Void) {
        Alamofire.request(getAllURL, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let respData):
                let jsonDecoder = JSONDecoder()
                
                if let studentData = try? jsonDecoder.decode(Response.self, from: respData) {
                    
                    let data = studentData.data
                    didGetStudents(data)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private static let createUserUrl = "http://35.237.123.122/api/user/"
    
    static func createUser(name: String, netid: String, year: String, school: String) {
        let parameter: [String: Any] = [
            "name": name,
            "netid": netid,
            "year": year,
            "school": school
        ]
       
        Alamofire.request(createUserUrl, method: .post, parameters: parameter, encoding: JSONEncoding.default)
        
    }
    
    //add new interest to user
    private static let postNewInterestURL = "http://35.237.123.122/api/user/interest/add/"
    
    static func postNewInterests(netid: String, interest_name: String) {
        
        let parameter: [String: Any] = ["netid":netid, "interest_name": interest_name]
        Alamofire.request(postNewInterestURL, method: .post, parameters: parameter, encoding: JSONEncoding.default)
        
    }
    
}
