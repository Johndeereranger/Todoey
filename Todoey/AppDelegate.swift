//
//  AppDelegate.swift
//  Todoey
//
//  Created by Amie Smith on 4/7/19.
//  Copyright © 2019 Amie Smith. All rights reserved.
//  printed in the middle of lec 236  this was trimmed significantly after that

import UIKit
import CoreData // added 236 4:03

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        print("didFinishlaunchingwithoptions")

        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
     } //remvoed lec236 3:5
    
    // MARK: - Core Data stack
    // lec 236 shows how to copy and set this up.
    
    lazy var persistentContainer: NSPersistentContainer = {
 
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}





