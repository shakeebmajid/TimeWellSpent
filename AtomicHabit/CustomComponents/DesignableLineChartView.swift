//
//  DesignableLineChartView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 12/25/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import Foundation
import Charts

public class WeekXAxisChartFormatter: NSObject, IAxisValueFormatter{
    
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]


    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        print("about to format day of week for value: \(value)")
        return days[Int(value)]
    }
}

public class MonthXAxisChartFormatter: NSObject, IAxisValueFormatter{
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        print("about to format day of month")
        return String(Int(value))
    }
}

public class YAxisChartFormatter: NSObject, IAxisValueFormatter{
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        return "\(TimeService.formatTimeAbbreviated(seconds: Int(value * 60)))"
    }
}
