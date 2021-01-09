//
//  JournalViewModel.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/9/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import Foundation

class JournalViewModel: ObservableObject {
    
    
    @Published var logs = [Interval]()
    @Published var logsByDate = [Date:[Interval]]()
    var habit: String
    
    
    init(habit: String) {
        self.habit = habit
        fetchData()
    }
    
    func fetchData() {
        logs = TimeService.getIntervalsForCurrentWeek(habit: habit) as! [Interval]
        logsByDate = Dictionary(grouping: logs) { ($0.createdAt ?? Date()) }
    }
    
    
    
    
}
