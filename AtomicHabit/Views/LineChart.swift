//
//  LineChartView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/3/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {

    @ObservedObject var lineChartViewModel: LineChartViewModel
    
    typealias UIViewType = LineChartView
    

    init(habit: String) {
        lineChartViewModel = LineChartViewModel(habit: habit)
    }
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChart = createChartFromEntries(entries: lineChartViewModel.entries, animate: true)
        
        return lineChart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
    
    func createChartFromEntries(entries: [ChartDataEntry], animate: Bool) -> LineChartView {
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
        var lineChart = LineChartView()
        
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
        if (animate) {
            lineChart.animate(xAxisDuration: 1)
        }
        return lineChart
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(habit: "Meditation")
    }
}
