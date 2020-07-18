//
//  TimeService.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/16/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TimeService {
    
    // returns sum of time across intervals within date range in seconds
    static func sumTimeFromDates(habit: String, startDate: Date, endDate: Date) -> Int {
        let intervals = getIntervals(habit: habit, startDate: startDate, endDate: endDate)
        return sumTimeFromIntervals(intervals: intervals)
    }
    
    // returns sum of time across intervals in seconds
    static func sumTimeFromIntervals(intervals: [NSManagedObject]) -> Int {
        var total = 0
        for interval in intervals {
            total += interval.value(forKey: "seconds") as! Int
        }
        
        return total
    }
    
    static func getIntervalsForCurrentDay(habit: String) -> [NSManagedObject] {
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        
        return getIntervals(habit: habit, startDate: startDate, endDate: now)
    }
    
    static func getIntervalsForCurrentWeek(habit: String) -> [NSManagedObject] {
        let now = Date()
        let startDate = now.startOfWeek!
        
        return getIntervals(habit: habit, startDate: startDate, endDate: now)
    }
    
    static func getIntervals(habit: String, startDate: Date, endDate: Date) -> [NSManagedObject] {
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        print("start: \(format.string(from: startDate))")
        print("end: \(format.string(from: endDate))")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Interval")

        
        let startPredicate = NSPredicate(format: "createdAt >= %@", startDate as CVarArg)
        let endPredicate = NSPredicate(format: "createdAt <= %@", endDate as CVarArg)
        let habitPredicate = NSPredicate(format: "habit == %@", habit)
        
        let subPredicates = [startPredicate, endPredicate, habitPredicate]
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
        request.predicate = compound
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print("Fetched!")
            return result as! [NSManagedObject]
        } catch {
            print("Failed!")
        }
        return []
    }

}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .iso8601)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return monday
    }
}
