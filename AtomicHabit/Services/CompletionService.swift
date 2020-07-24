//
//  CompletionService.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/23/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CompletionService {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func getCompletionsForWeek(habit: String) -> [NSManagedObject] {
        let startOfWeek = Date().startOfWeek!
        let endOfWeek = startOfWeek.changeDays(by: 7)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Completion")
        let habitPredicate = NSPredicate(format: "habit == %@", habit)
        let startPredicate = NSPredicate(format: "date >= %@", startOfWeek as CVarArg)
        let endPredicate = NSPredicate(format: "date < %@", endOfWeek as CVarArg)
        let predicates = [habitPredicate, startPredicate, endPredicate]
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        let sectionSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
        request.predicate = compound
        request.returnsObjectsAsFaults = false
            
        do {
            let result = try context.fetch(request)
            if (result as! [NSManagedObject]).count == 7 {
                print("retrieved existing week")
                return result as! [NSManagedObject]
            } else {
                print("count: \((result as! [NSManagedObject]).count)")
                print("created completions for new week")
                return createCompletionsForWeek(habit: habit)
            }
            
        } catch {
            print("Failed!")
        }
        return []
    }
    
    static func createCompletionsForWeek(habit: String) -> [NSManagedObject] {

        var date = Date().startOfWeek!
        
        var completionsForWeek = [] as [NSManagedObject]
        for i in stride(from: 0, to: 7, by: 1) {
            let entity = NSEntityDescription.entity(forEntityName: "Completion", in: context)
            let newEntity = NSManagedObject(entity: entity!, insertInto: context)
            newEntity.setValue(date, forKey: "date")
            newEntity.setValue(habit, forKey: "habit")
            newEntity.setValue(false, forKey: "complete")
            completionsForWeek.append(newEntity)
            print("completion date: \(date)")
            date = date.changeDays(by: 1)
        }
        
        do {
            try context.save()
            print("saved")
            return completionsForWeek
            
        } catch {
            print("Failed saving")
        }
        
        return []
    }
    
    
    static func saveCompletion() {
        do {
            try context.save()
            print("saved")
            
        } catch {
            print("Failed saving")
        }
    }
}
