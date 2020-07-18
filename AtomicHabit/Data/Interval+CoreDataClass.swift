//
//  Interval+CoreDataClass.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/8/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Interval)
public class Interval: NSManagedObject {
    public override func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: "createdAt")
        print("\(Date())")
    }
}
