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
    
    static func getHabits() -> [NSManagedObject] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habit")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
            
        } catch {
            print("Failed!")
        }
        return []
    }
    
}
