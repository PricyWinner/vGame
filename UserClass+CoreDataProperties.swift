//
//  UserClass+CoreDataProperties.swift
//  vGame
//
//  Created by Alexander Imanuel on 17/01/23.
//
//

import Foundation
import CoreData


extension UserClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserClass> {
        return NSFetchRequest<UserClass>(entityName: "UserClass")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension UserClass : Identifiable {

}
