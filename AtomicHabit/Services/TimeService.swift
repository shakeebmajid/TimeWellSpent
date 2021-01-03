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
    
    static func saveTime(habit: String, seconds: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Interval", in: context)
        
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(seconds, forKey: "seconds")
        newEntity.setValue(habit, forKey: "habit")
        
        do {
            try context.save()
            
        } catch {
            print("Failed saving")
        }
    }
    
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
    

    
    static func getWeekStartNWeeksBefore(n: Int) -> Date {
        let now = Date()
        let startOfWeek = now.startOfWeek!
        return Calendar.current.date(byAdding: .day, value: n * -7, to: startOfWeek)!
    }
    
    static func getWeekIntervalSumNWeeksBefore(habit: String, n: Int) -> Int {
        let startDate = getWeekStartNWeeksBefore(n: n)
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        return sumTimeFromDates(habit: habit, startDate: startDate, endDate: endDate)
    }
    
    static func getAllWeekIntervalSums(habit: String) -> ([Date], [Int]) {
        var n = 1
        var dates = [] as! [Date]
        var intervalSums = [] as! [Int]
        while(getWeekIntervalSumNWeeksBefore(habit: habit, n: n) != 0) {
            intervalSums.append(getWeekIntervalSumNWeeksBefore(habit: habit, n: n))
            dates.append(getWeekStartNWeeksBefore(n: n))
            n += 1
        }
        
        return (dates, intervalSums)
    }
    
    // newest method, use instead of other ones below
    static func getIntervalsFromStartDate(startDate: Date, habit: String) -> [NSManagedObject] {
        let now = Date()
        
        return getIntervals(habit: habit, startDate: startDate, endDate: now)
    }
    
    // deprecated
    static func getIntervalsForCurrentDay(habit: String) -> [NSManagedObject] {
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        
        return getIntervals(habit: habit, startDate: startDate, endDate: now)
    }
    
    // deprecated
    static func getIntervalsForCurrentWeek(habit: String) -> [NSManagedObject] {
        let now = Date()
        let startDate = now.startOfWeek!
        
        return getIntervals(habit: habit, startDate: startDate, endDate: now)
    }
    
    static func getIntervals(habit: String, startDate: Date, endDate: Date) -> [NSManagedObject] {
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
//        print("start: \(format.string(from: startDate))")
//        print("end: \(format.string(from: endDate))")
        
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
            return result as! [NSManagedObject]
        } catch {
            print("Failed!")
        }
        return []
    }
    
    static func getAllIntervals(habit: String) -> [NSManagedObject] {
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let now = Date()
        print("now: \(format.string(from: now))")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Interval")
        
        let endPredicate = NSPredicate(format: "createdAt <= %@", now as CVarArg)
        let habitPredicate = NSPredicate(format: "habit == %@", habit)
        
        let subPredicates = [endPredicate, habitPredicate]
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
        request.predicate = compound
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
        } catch {
            print("Failed!")
        }
        return []
    }
    
    
    static func sumIntervalsForCurrentDay(habit: String) -> Int {
        let intervals = getIntervalsForCurrentDay(habit: habit)
        let totalTime = sumTimeFromIntervals(intervals: intervals)
        print("Time today for habit: \(totalTime)")
        
        return totalTime
    }
    
    static func sumIntervalsForCurrentWeek(habit: String) -> Int {
        let intervals = getIntervalsForCurrentWeek(habit: habit)
        let totalTime = sumTimeFromIntervals(intervals: intervals)
        print("Time this week for habit: \(totalTime)")
        
        return totalTime
    }
    
    static func sumIntervalsForCurrentMonth(habit: String) -> Int {
        let intervals = getIntervalsFromStartDate(startDate: Date.startOfMonth, habit: habit)
        let totalTime = sumTimeFromIntervals(intervals: intervals)
        print("Time this month for habit: \(totalTime)")
        
        return totalTime
    }
    
    
    static func sumAllIntervals(habit: String) -> Int {
        let allIntervals = getAllIntervals(habit: habit)
        let totalTime = sumTimeFromIntervals(intervals: allIntervals)
        print("Total time for habit: \(totalTime)")
        
        return totalTime
    }

    static func formatTime(seconds: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter.string(from: Date(timeIntervalSinceReferenceDate: TimeInterval(seconds)))
    }
    
    static func formatSeconds(seconds: Int) -> String {

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [ .hour, .minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]

        let formattedDuration = formatter.string(from: TimeInterval(seconds))!
        
        return formattedDuration
    }
    
    static func formatTimeAbbreviated(seconds: Int) -> String {
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [ .day, .hour, .minute, .second ]
        formatter.zeroFormattingBehavior = [ .dropAll ]
        formatter.maximumUnitCount = 2

        let formattedDuration = formatter.string(from: TimeInterval(seconds))!
        
        return formattedDuration
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .iso8601)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return monday
    }
    
    static var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: Date())

        return  calendar.date(from: components)!
    }
}
