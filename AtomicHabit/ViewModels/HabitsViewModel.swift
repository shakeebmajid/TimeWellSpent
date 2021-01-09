//
//  HabitListViewModel.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/1/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
class HabitsViewModel: ObservableObject {
    @Published var habitsByCategory = [String: [Habit]]()
    
    func fetchData() {
        let habits = HabitService.getHabits() as [Habit]
        
        habitsByCategory = Dictionary(grouping: habits) { ($0.category ?? "Other") }
        HabitService.updateFields()

        print("habits: \(habitsByCategory)")

    }
    
    
}
