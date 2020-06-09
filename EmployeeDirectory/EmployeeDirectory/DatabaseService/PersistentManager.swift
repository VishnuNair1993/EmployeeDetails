//
//  PersistentManager.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import Foundation
import CoreData

final class PersistentManager  {
    private init(){}
    static let shared = PersistentManager()
    let modelName = "EmployeeDirectory"
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy var context = persistentContainer.viewContext
    
    
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        //let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                debugPrint("\n Saved Successfully \n")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error while saving \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    func fetch<T: NSManagedObject>(_ objectType : T.Type)->[T]{
       // context.fetch(T.fetchRequest()) as?
        let entityName  = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let fetchedObject = try context.fetch(fetchRequest) as? [T]
            if fetchedObject!.isEmpty{debugPrint("\n Cannot fetch : Empty Data \n")}
            return fetchedObject ?? [T]()
        }catch{
            debugPrint("\n Error while fetching : \(error) \n")
            return [T]()
        }
        
    }
    
    func delete(_ object : NSManagedObject){
        context.delete(object)
        saveContext()
         debugPrint("\n Deleted Successfully \n")
    }
    
}

