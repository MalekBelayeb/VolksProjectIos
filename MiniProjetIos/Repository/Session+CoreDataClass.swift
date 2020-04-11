//
//  Session+CoreDataClass.swift
//  
//
//  Created by malek belayeb on 11/21/19.
//
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSManagedObject {
    
    @NSManaged public var username: String?
    @NSManaged public var isconnected: Int16
    @NSManaged public var rememberme: Int16
    
}
