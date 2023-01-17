//
//  AdminService.swift
//  vGame
//
//  Created by Alexander Imanuel on 13/01/23.
//

import Foundation
import CoreData

class AdminService:NSObject{
    
    public static var admins:[AdminClass] = []
    public static var currentAdmin = AdminClass()
    //generate admin account
    public static func generateAdmin(){
        if(!checkAdmin()){
            createAdmin(username: "admin", password: "admin")
            createAdmin(username: "admin1", password: "admin")
            createAdmin(username: "admin2", password: "admin")
            print("generate Admin")
        }else{
            print("do nothing")
        }
    }
    
    public static func checkAdmin() -> Bool{
        let req : NSFetchRequest<AdminClass> = AdminClass.fetchRequest()
        AdminService.admins = []
        var adminFound:Bool = false
        do{
            AdminService.admins = try DataManagerClass.shared.persistentContainer.viewContext.fetch(req)
            if(!AdminService.admins.isEmpty){
                adminFound = true
                
            }
        }catch let er{
            print("gagal dapat product\(er)")
        }
        return adminFound
    }
    
    public static func createAdmin(username:String, password:String){
        let admin = AdminClass(context: DataManagerClass.shared.persistentContainer.viewContext)
        admin.username = username
        admin.password = password
        DataManagerClass.shared.save()
    }
//    public static func getAdmin(username:String, password:String){
//        let req : NSFetchRequest<AdminClass> = AdminClass.fetchRequest()
//        var fetchedAdmin:[AdminClass] = []
//        var valid:Bool = false
//        do{
//            fetchedAdmin = try DataManagerClass.shared.persistentContainer.viewContext.fetch(req)
//
//            for user in fetchedAdmin {
//                if(user.value(forKey: "email") as! String == email && user.value(forKey: "password") as! String == password){
//                                    currentUser = user
//                                    valid = true
//                                    break
//                                }else{
//                                    valid = false
//                                    print("password atau email salah email:\(String(describing: user.value(forKey: "userEmail"))) Pass: \(String(describing: user.value(forKey: "userPassword")))")
//                                }
//            }
//        }catch let error{
//            print("Error getting User\(error)")
//        }
//
//        return valid
//
//    }
public static func getAdmin(username:String, password:String)->Bool{
    let req : NSFetchRequest<AdminClass> = AdminClass.fetchRequest()
    req.predicate = NSPredicate(format: "username = %@ AND password = %@", username, password)

    var fetchedAdmin:[AdminClass] = []
    do{
        fetchedAdmin = try DataManagerClass.shared.persistentContainer.viewContext.fetch(req)
//        print(fetchedAdmin.count)
//        print(fetchedAdmin[0].username!)
        if(!fetchedAdmin.isEmpty){
            currentAdmin = fetchedAdmin[0]
            return true
        }else{
            return false
        }
    }catch let er{
        print("gagal dapat admin\(er)")
    }
    return false
}
}
