//
//  TimeViewModel.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/2/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
class TimeViewModel: ObservableObject {
    
    @Published var times = [String: String]()
    var habit: String
    
    init(habit: String) {
        self.habit = habit
        fetchData()
    }
    
    func fetchData() {
        let dayTime = TimeService.sumIntervalsForCurrentDay(habit: habit)
        times["day"] = TimeService.formatTimeAbbreviated(seconds: dayTime)

        let weekTime = TimeService.sumIntervalsForCurrentWeek(habit: habit)
        times["week"] = TimeService.formatTimeAbbreviated(seconds: weekTime)
        
        let monthTime = TimeService.sumIntervalsForCurrentMonth(habit: habit)
        times["month"] = TimeService.formatTimeAbbreviated(seconds: monthTime)
        
        let totalTime = TimeService.sumAllIntervals(habit: habit)
        times["all"] = TimeService.formatTimeAbbreviated(seconds: totalTime)

        print(times)
    }
    
    func submitTime(hours: Int, minutes: Int) {
        TimeService.saveTime (
            habit : habit,
            seconds : hours * 60 * 60 + minutes * 60
        )
        fetchData()
        
    }
    
    
    
    
}
