//
//  TimeView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/3/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

struct TimeView: View {
    @ObservedObject private var timeViewModel: TimeViewModel
    
    init(habit: String) {
        timeViewModel = TimeViewModel(habit: habit)
    }
    var body: some View {
        VStack {
            HStack {
                Text("Time")
                Spacer()
                NavigationLink(destination: SubmitView(timeViewModel: timeViewModel), label: {
                    Text("+")
                })
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            HStack {
                VStack {
                    Text("Day")
                    Text(timeViewModel.times["day"] ?? "N/A")
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Text("Week")
                    Text(timeViewModel.times["week"] ?? "N/A")
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Text("Month")
                    Text(timeViewModel.times["month"] ?? "N/A")
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Text("All")
                    Text(timeViewModel.times["all"] ?? "N/A")
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
        .padding(
            EdgeInsets(
                top: 10,
                leading: 10,
                bottom: 10,
                trailing: 10
            )
        )
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(habit: "Meditation")
    }
}
