//
//  User.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/19/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        password <- map["password"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        address <- map["address"]
        phoneNumber <- map["phoneNumber"]
    }
    
    
    
    var id: Int?
    var username:String?
    var password :String?
    var firstName:String = ""
    var lastName:String = ""
    var email : String = ""
    var address:String = ""
    var phoneNumber: Int64 = 0
   
    var partner  = ""
    var sexe = ""
    var job = ""
    var birthDate = ""
    
    init()
    {
    
    }
    
    init(username:String,password:String) {
        self.username = username
        self.password = password
    }
    
    
    
    init(username:String,password:String,firstName:String,lastName:String,email:String,address:String,phoneNumber:Int64) {
           self.username = username
           self.password = password
        self.firstName =  firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
    }
      init(username:String,firstName:String,lastName:String,email:String,address:String,phoneNumber:Int64) {
             self.username = username
          self.firstName =  firstName
          self.lastName = lastName
          self.email = email
          self.address = address
          self.phoneNumber = phoneNumber
      }
    
    
    required init?(map: Map) {
        

    }
    
    
}
