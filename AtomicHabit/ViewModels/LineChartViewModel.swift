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
    var type: String?

    init(habit: String) {
        self.habit = habit
    }
    
    func fetchData() {
        entries = [ChartDataEntry]()
        if type == "Week" || type == nil {
            print("fetch data for week")
            fetchDataForWeek()
        } else {
            print("fetch data for month")
            fetchDataForMonth()
        }
    }
    
    func fetchDataForWeek() {
        for i in stride(from: 0, through: 6, by: 1) {
            let startDate = Date().startOfWeek?.changeDays(by: i)
            let endDate = startDate?.endOfDay
            
            let time = Double(TimeService.sumTimeFromDates(habit: habit, startDate: startDate!, endDate: endDate!)) / 60
            let entry = ChartDataEntry(x: Double(i), y: time)
            entries.append(entry)
        }
    }
    
    func fetchDataForMonth() {
        var startDay = Date().startOfMonth
        let endOfMonth = startDay.endOfMonth
        var i = 0
        
        while startDay < endOfMonth {
            
            // sum time for day and add entry
            let time = Double(TimeService.sumTimeFromDates(habit: habit, startDate: startDay, endDate: startDay.endOfDay)) / 60
            let entry = ChartDataEntry(x: Double(i), y: time)
            entries.append(entry)
            
            // increment day
            startDay = startDay.changeDays(by: 1)
            i += 1
        }
    }
}
