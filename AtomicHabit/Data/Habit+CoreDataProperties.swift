//
//  Habit+CoreDataProperties.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 6/28/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var name: String?

}
