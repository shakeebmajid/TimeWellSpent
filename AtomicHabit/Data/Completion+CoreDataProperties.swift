//
//  Completion+CoreDataProperties.swift
//  
//
//  Created by Shakeeb Majid on 7/22/20.
//
//

import Foundation
import CoreData


extension Completion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Completion> {
        return NSFetchRequest<Completion>(entityName: "Completion")
    }

    @NSManaged public var complete: Bool
    @NSManaged public var habit: String?
    @NSManaged public var date: Date?

}
