//
//  AdminClass+CoreDataProperties.swift
//  vGame
//
//  Created by Alexander Imanuel on 17/01/23.
//
//

import Foundation
import CoreData


extension AdminClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdminClass> {
        return NSFetchRequest<AdminClass>(entityName: "AdminClass")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension AdminClass : Identifiable {

}
