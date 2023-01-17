//
//  DataManager.swift
//  cucuan
//
//  Created by Alexander Imanuel on 08/01/23.
//

import Foundation
import CoreData
class DataManagerClass{
    static let shared = DataManagerClass()
      lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "vGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        })
        return container
      }()
    //Core Data Saving support
      func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
          do {
              try context.save()
              print("berhasil save")
          } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
      }
}
