//
//  HabitController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/14/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData
import Charts

class HabitController: UIViewController {
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var barChart: BarChartView!
    var habit: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = habit!
        
        dayTotalsBarChart()
    }
    
    func dayTotalsBarChart() {
        var entries = [] as! [BarChartDataEntry]
        var colors = [] as! [NSUIColor]
        for i in stride(from: -7, through: -1, by: 1) {
            let startDate = Date().changeDays(by: i)
            let endDate = Date().changeDays(by: i + 1)
            
            let time = Double(TimeService.sumTimeFromDates(habit: habit!, startDate: startDate, endDate: endDate)) / 3600
            print(time)
            let entry = BarChartDataEntry(x: Double(i), y: time)
            entry.accessibilityLabel = "\(startDate)"
            colors.append(UIColor.random)
                       
            entries.append(entry)
        }
                   
        let chartDataSet = BarChartDataSet(entries: entries, label: nil)
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = colors as [NSUIColor]
      
        barChart.data = chartData
    }
    
    
    
    @IBAction func submitTime(_ sender: Any) {
        if !timeTextField.text!.isEmpty {
            let seconds = Int(timeTextField.text!)! * 60
            timeTextField.text = ""
            TimeService.saveTime(habit: habit!, seconds: seconds)
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTimer" {
            let controller = segue.destination as! TimerController
            controller.habit = habit!
        } else if segue.identifier == "toLog" {
            let destination = segue.destination as! LogController
            
            destination.habit = habit!
        }
        
    }
}

extension Date {
    func changeDays(by days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}
