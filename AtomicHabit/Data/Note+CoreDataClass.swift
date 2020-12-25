//
//  Note+CoreDataClass.swift
//  
//
//  Created by Shakeeb Majid on 7/19/20.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    public override func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: "createdAt")
        print("\(Date())")
    }

}
