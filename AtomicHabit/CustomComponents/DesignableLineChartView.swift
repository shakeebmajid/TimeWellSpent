//
//  DesignableLineChartView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 12/25/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import Foundation
import Charts

@IBDesignable
class DesignableLineChartView: LineChartView {
    
    override func prepareForInterfaceBuilder() {
        createTestChart()
    }
    
    func createTestChart() {
        let testEntries = createTestEntries()
        createChartFromEntries(entries: testEntries, animate: false)
        
    }
    
    func createTestEntries() -> [ChartDataEntry] {
        var entries = [] as [ChartDataEntry]
        let testEntry1 = ChartDataEntry(x: 0, y: 20)
        let testEntry2 = ChartDataEntry(x: 1, y: 30)
        let testEntry3 = ChartDataEntry(x: 2, y: 80)
        let testEntry4 = ChartDataEntry(x: 3, y: 40)
        let testEntry5 = ChartDataEntry(x: 4, y: 0)
        let testEntry6 = ChartDataEntry(x: 5, y: 90)
        let testEntry7 = ChartDataEntry(x: 6, y: 100)

        entries.append(testEntry1)
        entries.append(testEntry2)
        entries.append(testEntry3)
        entries.append(testEntry4)
        entries.append(testEntry5)
        entries.append(testEntry6)
        entries.append(testEntry7)
        
        return entries
    }
    
    func createEntries(habit: String) -> [ChartDataEntry] {
        var entries = [] as [ChartDataEntry]
        for i in stride(from: 0, through: 6, by: 1) {
            let startDate = Date().startOfWeek?.changeDays(by: i)
            let endDate = Date().startOfWeek?.changeDays(by: i + 1)
            
            let time = Double(TimeService.sumTimeFromDates(habit: habit, startDate: startDate!, endDate: endDate!)) / 60
            let entry = ChartDataEntry(x: Double(i), y: time)
            entries.append(entry)
        }
        
        return entries
    }
    
    func createChartFromEntries(entries: [ChartDataEntry], animate: Bool) {
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
        self.data = chartData
        
        // line chart view itself
        self.backgroundColor = UIColor(red: 235/255, green: 169/255, blue: 24/255, alpha: 1.0)
        
        // X Axis
//        lineChart.xAxis.granularity = 1
        let xChartFormatter = XAxisChartFormatter()
        let xAxis = XAxis()
        xAxis.valueFormatter = xChartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.xAxis.axisLineColor = .white
        // Right Axis
        self.rightAxis.enabled = false
        
        // Y Axis
        let yChartFormatter = YAxisChartFormatter()
        let yAxis = YAxis()
        yAxis.valueFormatter = yChartFormatter
        self.leftAxis.valueFormatter = yAxis.valueFormatter
        self.leftAxis.gridColor = .white
        self.leftAxis.axisLineColor = .white
        
        // disable legend
        self.legend.enabled = false
        
        // Line Chart View
        self.setExtraOffsets(left: 0, top: 10, right: 20, bottom: 5)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        if (animate) {
            self.animate(xAxisDuration: 1)
        }
    }
    
    func dayTotalsBarChart(habit: String) {
        
        let entries = createEntries(habit: habit)
        
        createChartFromEntries(entries: entries, animate: true)
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
        

        return "\(TimeService.formatTimeAbbreviated(seconds: Int(value * 60)))"
    }
}
