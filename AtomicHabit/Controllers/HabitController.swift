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
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var weekTimeLabel: UILabel!
    @IBOutlet weak var monthTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var addNoteButton: StandardButton!
    @IBOutlet weak var timeLogsButton: StandardButton!
    @IBOutlet weak var pieChartButton: StandardButton!
    var habit: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = habit!
        
        // retrieves the times for day, week, month, all
        setTimeLabels()
        dayTotalsBarChart()
    }
    
    func setTimeLabels() {
        // total time accumulated for habit
        let totalTime = TimeService.sumAllIntervals(habit: habit!)
        totalTimeLabel.text = ("\(TimeService.formatSeconds(seconds: totalTime))")
        
        let dayTime = TimeService.sumIntervalsForCurrentDay(habit: habit!)
        dayTimeLabel.text = ("\(TimeService.formatSeconds(seconds: dayTime))")

        let weekTime = TimeService.sumIntervalsForCurrentWeek(habit: habit!)
        weekTimeLabel.text = ("\(TimeService.formatSeconds(seconds: weekTime))")
        
        let monthTime = TimeService.sumIntervalsForCurrentMonth(habit: habit!)
        monthTimeLabel.text = ("\(TimeService.formatSeconds(seconds: monthTime))")
    }
    
    func dayTotalsBarChart() {
//        let entry = ChartDataEntry(x: Double(0), y: 0)
        var entries = [] as [ChartDataEntry]
        for i in stride(from: 0, through: 6, by: 1) {
            let startDate = Date().startOfWeek?.changeDays(by: i)
            let endDate = Date().startOfWeek?.changeDays(by: i + 1)
            
            let time = Double(TimeService.sumTimeFromDates(habit: habit!, startDate: startDate!, endDate: endDate!)) / 60
            let entry = ChartDataEntry(x: Double(i), y: time)
            entries.append(entry)
        }
                   
        // chart data set
        let chartDataSet = LineChartDataSet(entries: entries, label: "minutes completed")
        chartDataSet.drawValuesEnabled = true
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.circleHoleRadius = 2.0
        chartDataSet.circleRadius = 3.0
        chartDataSet.colors = [UIColor.white]
        chartDataSet.mode = .cubicBezier
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.lineWidth = 3
        chartDataSet.fill = Fill(color: UIColor.white)
        chartDataSet.fillAlpha = 0.4
        chartDataSet.drawFilledEnabled = true
        
        
        // chart data
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChart.data = chartData
        
        // line chart view itself
        lineChart.backgroundColor = UIColor(red: 235/255, green: 169/255, blue: 24/255, alpha: 1.0)
        
        // X Axis
//        lineChart.xAxis.granularity = 1
        let xChartFormatter = XAxisChartFormatter()
        let xAxis = XAxis()
        xAxis.valueFormatter = xChartFormatter
        lineChart.xAxis.valueFormatter = xAxis.valueFormatter
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChart.xAxis.axisLineColor = .white
        // Right Axis
        lineChart.rightAxis.enabled = false
        
        // Y Axis
        let yChartFormatter = YAxisChartFormatter()
        let yAxis = YAxis()
        yAxis.valueFormatter = yChartFormatter
        lineChart.leftAxis.valueFormatter = yAxis.valueFormatter
        lineChart.leftAxis.gridColor = .white
        lineChart.leftAxis.axisLineColor = .white
        
        // disable legend
        lineChart.legend.enabled = false
        
        // Line Chart View
        lineChart.setExtraOffsets(left: 0, top: 10, right: 20, bottom: 5)
        lineChart.layer.cornerRadius = 15
        lineChart.layer.masksToBounds = true
        lineChart.animate(xAxisDuration: 1)
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
        } else if segue.identifier == "toIntervalSums" {
            let destination = segue.destination as! IntervalSumController
            
            destination.habit = habit!
        }
        
    }
}

extension Date {
    func changeDays(by days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}

public class XAxisChartFormatter: NSObject, IAxisValueFormatter{
    
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]


    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        return days[Int(value)]
    }
}

public class YAxisChartFormatter: NSObject, IAxisValueFormatter{
    


    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        

        return "\(Int(value))m"
    }
}


