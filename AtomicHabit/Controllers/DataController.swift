//
//  DataController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/17/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import Charts
import CoreData

class DataController: UIViewController {
    @IBOutlet weak var pieChart: PieChartView!
    
    var habits: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        habits = HabitService.getHabits()
        
       getWeekTimes()
        // Do any additional setup after loading the view.
    }
    
    func getWeekTimes() {
        var entries = [] as [PieChartDataEntry]
        var colors = [] as [NSUIColor]
        for habit in habits {
            let name = habit.value(forKey: "name") as! String
            
            let time = Double(TimeService.sumTimeFromDates(habit: name as! String, startDate: Date().startOfWeek!, endDate: Date())) / 3600
            
            // only add to pie chart entries that have non zero values
            if (time > 0) {
                let entry = PieChartDataEntry(value: time)
                entry.label = (name as! String)
                colors.append(UIColor.random)
                
                entries.append(entry)
            }
            

        }
        
        let chartDataSet = PieChartDataSet(entries: entries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = colors as [NSUIColor]
       
        pieChart.data = chartData
    }

}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
