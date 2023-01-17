//
//  VoucherClass+CoreDataProperties.swift
//  vGame
//
//  Created by Alexander Imanuel on 17/01/23.
//
//

import Foundation
import CoreData


extension VoucherClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VoucherClass> {
        return NSFetchRequest<VoucherClass>(entityName: "VoucherClass")
    }

    @NSManaged public var credit: String?
    @NSManaged public var price: Double
    @NSManaged public var redeemCode: UUID?
    @NSManaged public var isUsed: Bool
    @NSManaged public var game: Game?

}

extension VoucherClass : Identifiable {

}
