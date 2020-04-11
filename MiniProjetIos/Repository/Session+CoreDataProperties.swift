//
//  Session+CoreDataProperties.swift
//  
//
//  Created by malek belayeb on 11/21/19.
//
//

import Foundation
import CoreData


extension Session {


    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }


}
