//
//  LineChartView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/13/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

struct LineChartSectionView: View {
    
    @ObservedObject var lineChartViewModel: LineChartViewModel
    @State var type = "Month"

    init(habit: String) {
        lineChartViewModel = LineChartViewModel(habit: habit)
        lineChartViewModel.type = "Month"
        lineChartViewModel.fetchData()
    }
    
    var body: some View {
        VStack {
            Text("Trends")
                .padding(.top, 10)
                .padding(.horizontal, 10)
            Picker(selection: $type, label: Text("Time span")) {
                            Text("Week").tag("Week")
                            Text("Month").tag("Month")
            }
            .onChange(of: type) { _ in
                print("fetch data for picker change")
                lineChartViewModel.type = type
                lineChartViewModel.fetchData()
            }
            .pickerStyle(SegmentedPickerStyle())
            
            LineChart(lineChartViewModel: lineChartViewModel)
        }
    }
}

struct LineChartSectionView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartSectionView(habit: "Meditation")
    }
}
