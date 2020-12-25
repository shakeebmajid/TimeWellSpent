//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Shakeeb Majid on 7/19/20.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var habit: String?
    @NSManaged public var text: String?

}
