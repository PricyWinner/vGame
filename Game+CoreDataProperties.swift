//
//  Game+CoreDataProperties.swift
//  vGame
//
//  Created by Alexander Imanuel on 17/01/23.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var vouchers: Set<VoucherClass>?

}

// MARK: Generated accessors for vouchers
extension Game {

    @objc(addVouchersObject:)
    @NSManaged public func addToVouchers(_ value: VoucherClass)

    @objc(removeVouchersObject:)
    @NSManaged public func removeFromVouchers(_ value: VoucherClass)

    @objc(addVouchers:)
    @NSManaged public func addToVouchers(_ values: NSSet)

    @objc(removeVouchers:)
    @NSManaged public func removeFromVouchers(_ values: NSSet)

}

extension Game : Identifiable {

}
