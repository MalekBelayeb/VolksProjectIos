//
//  UserSession+CoreDataProperties.swift
//  
//
//  Created by malek belayeb on 11/27/19.
//
//

import Foundation
import CoreData


extension UserSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSession> {
        return NSFetchRequest<UserSession>(entityName: "UserSession")
    }


}
