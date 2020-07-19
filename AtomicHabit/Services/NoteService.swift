//
//  NoteService.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/19/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NoteService {
    
    static func saveNote(habit: String, text: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(text, forKey: "text")
        newEntity.setValue(habit, forKey: "habit")
        
        do {
            try context.save()
            print("saved")
            
        } catch {
            print("Failed saving")
        }
    }
    
    
    static func getNotes(habit: String) -> [NSManagedObject] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let habitPredicate = NSPredicate(format: "habit == %@", habit)
        request.predicate = habitPredicate
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
