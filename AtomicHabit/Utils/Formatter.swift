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
         let formatter = DateFormatter()
         formatter.dateFormat = "MMM DD, yyyy"
         return formatter.string(from: date)
     }
    
    
    static func formatTimeFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter.string(from: date)

     }
    
}
