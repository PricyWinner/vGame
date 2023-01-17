//
//  GameService.swift
//  vGame
//
//  Created by Alexander Imanuel on 13/01/23.
//

import UIKit
import CoreData

class GameService: NSObject {
    public static var gameCategory:[Game] = []
    
    public static func generateCategory(){
        if(!checkCategory()){
            createCategory(name: "Steam", image: "steam" )
            createCategory(name: "Google Play",image: "google" )
            createCategory(name: "App Store",image: "apple" )
            createCategory(name: "Amazon",image: "amazon" )
            print("generate Category")
            getCategory()
        }else{
            print("do nothing")
        }
    }
    
    public static func checkCategory() -> Bool{
        let req : NSFetchRequest<Game> = Game.fetchRequest()
        GameService.gameCategory = []
        var categoryFound : Bool = false
        do{
            GameService.gameCategory = try DataManagerClass.shared.persistentContainer.viewContext.fetch(req)
            if(!GameService.gameCategory.isEmpty){
                categoryFound = true
                
            }
        }catch let er{
            print("gagal dapat product\(er)")
        }
        return categoryFound
    }
    public static func getCategory(){
        let req : NSFetchRequest<Game> = Game.fetchRequest()
        GameService.gameCategory = []
        do{
            GameService.gameCategory = try DataManagerClass.shared.persistentContainer.viewContext.fetch(req)
        }catch let er{
            print("gagal dapat product\(er)")
        }
    }
    
    public static func createCategory(name:String, image:String){
        let category = Game(context: DataManagerClass.shared.persistentContainer.viewContext)
        category.name = name
        category.image = image
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

}
