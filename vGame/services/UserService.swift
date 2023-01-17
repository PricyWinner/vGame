//
//  UserService.swift
//  vGame
//
//  Created by Alexander Imanuel on 13/01/23.
//

import Foundation
import CoreData

class UserService{
    public static var currentUser = UserClass()
    
    //function user
    public static func createUser(tfName: String, tfEmail: String, tfPassword: String){
        let user = UserClass(context: DataManagerClass.shared.persistentContainer.viewContext)
        user.username = tfName
        user.email = tfEmail
        user.password = tfPassword
        DataManagerClass.shared.save()
    }
    
    public static func getUser(email:String, password:String) -> Bool {
        let req : NSFetchRequest<UserClass> = UserClass.fetchRequest()
        var fetchedUsers:[UserClass] = []
        var valid:Bool = false
        do{
            fetchedUsers = try DataManagerClass.shared.persistentContainer.viewContext.fetch(req)
            
            for user in fetchedUsers {
                if(user.value(forKey: "email") as! String == email && user.value(forKey: "password") as! String == password){
                                    currentUser = user
                                    valid = true
                                    break
                                }else{
                                    valid = false
//                                    print("password atau email salah email:\(String(describing: user.value(forKey: "userEmail"))) Pass: \(String(describing: user.value(forKey: "userPassword")))")
                                }
            }
        }catch let error{
            print("Error getting User\(error)")
        }
        
        return valid
    }

    
}
