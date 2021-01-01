//
//  HabitService.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/17/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HabitService {
    
    static func getHabits() -> [Habit] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habit")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            return result as! [Habit]
            
        } catch {
            print("Failed!")
        }
        return []
    }
    
    static func updateFields() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Habit")

        fetchRequest.predicate = NSPredicate(format: "name == 'Meditation'")

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results?[0].setValue("Health", forKey: "category")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try context.save()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
    }
    

}
