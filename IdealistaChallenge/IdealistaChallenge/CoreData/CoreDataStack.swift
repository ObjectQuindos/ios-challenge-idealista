//
//  CoreDataStack.swift
//  IdealistaChallenge
//

import CoreData
import UIKit

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var persistentContainer: NSPersistentContainer {
        return appDelegate.persistentContainer
    }
    
    // (UI)
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Save changes
    func saveContext() {
        appDelegate.saveContext()
    }
}
