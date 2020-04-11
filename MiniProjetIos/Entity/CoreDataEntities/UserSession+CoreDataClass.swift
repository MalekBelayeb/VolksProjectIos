//
//  UserSession+CoreDataClass.swift
//  
//
//  Created by malek belayeb on 11/27/19.
//
//

import Foundation
import CoreData

@objc(UserSession)
public class UserSession: NSManagedObject {

    
    @NSManaged public var username: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var phoneNumber: Int32
    @NSManaged public var isconnected: Int16
    @NSManaged public var rememberme: Int16
    @NSManaged public var sexe: String?
    @NSManaged public var birth_date: String?
    @NSManaged public var job: String?
    @NSManaged public var partner: String?


    	    
}
