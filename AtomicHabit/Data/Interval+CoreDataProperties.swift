//
//  Interval+CoreDataProperties.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/8/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//
//

import Foundation
import CoreData


extension Interval {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Interval> {
        return NSFetchRequest<Interval>(entityName: "Interval")
    }

    @NSManaged public var habit: String?
    @NSManaged public var note: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var seconds: Int32

}
