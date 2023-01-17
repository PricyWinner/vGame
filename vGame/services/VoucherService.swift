//
//  VoucherService.swift
//  vGame
//
//  Created by Alexander Imanuel on 13/01/23.
//

import Foundation
import CoreData
class VoucherService:NSObject{
    public static var vouchers:[VoucherClass] = []
    
    public static func createVoucher(credit:String, price:Double, game:Game){
        let voucher = NSEntityDescription.insertNewObject(forEntityName: "VoucherClass", into: DataManagerClass.shared.persistentContainer.viewContext) as! VoucherClass
        
        voucher.credit = credit
        voucher.price = price
        voucher.isUsed = false
        voucher.redeemCode = UUID()
        game.addToVouchers(voucher)
        
        DataManagerClass.shared.save()
    }
    
    public static func getVouchers(game:Game){
        let req : NSFetchRequest<VoucherClass> = VoucherClass.fetchRequest()
        req.predicate = NSPredicate(format: "game = %@ AND isUsed = %@", game, "false")
        vouchers = []
        do{
            vouchers = try DataManagerClass.shared.persistentContainer.viewContext.fetch(req)
            print(vouchers.count)
        }catch let er{
            print("gagal dapat product\(er)")
        }
    }
    
    public static func buyVoucher(voucher:VoucherClass){
        let voucher = voucher
        voucher.isUsed = true
        DataManagerClass.shared.save()
        getVouchers(game: voucher.game!)
    }
    public static func deleteVoucher(voucher:VoucherClass){
        let context = DataManagerClass.shared.persistentContainer.viewContext
        context.delete(voucher)
        DataManagerClass.shared.save()
        print("berhasil delete")
    }
    public static func updateVoucher(credit:String, price:Double, voucher:VoucherClass){
        let voucher = voucher
        
        voucher.credit = credit
        voucher.price = price
        
        DataManagerClass.shared.save()
    }
}
