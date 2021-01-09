//
//  Formatter.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/9/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import Foundation


class Formatter {
    static func formatDate(date: Date) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MMM DD, yyyy"
         return dateFormatter.string(from: date)
     }
    
    
    
}
