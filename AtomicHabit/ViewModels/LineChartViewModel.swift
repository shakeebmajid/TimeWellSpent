//
//  LineChartViewModel.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/3/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import Foundation
import Charts

class LineChartViewModel: ObservableObject {

    @Published var entries = [ChartDataEntry]()
    var habit: String

    init(habit: String) {
        self.habit = habit
        fetchData()
    }
    
    func fetchData() {
        for i in stride(from: 0, through: 6, by: 1) {
            let startDate = Date().startOfWeek?.changeDays(by: i)
            let endDate = Date().startOfWeek?.changeDays(by: i + 1)
            
            let time = Double(TimeService.sumTimeFromDates(habit: habit, startDate: startDate!, endDate: endDate!)) / 60
            let entry = ChartDataEntry(x: Double(i), y: time)
            entries.append(entry)
        }
    }
    
}
