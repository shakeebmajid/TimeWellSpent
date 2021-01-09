//
//  JournalView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/9/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

struct JournalView: View {
    @ObservedObject private var journalViewModel: JournalViewModel
    
    init(habit: String) {
        journalViewModel = JournalViewModel(habit: habit)
    }
    var body: some View {
        List {
            ForEach(Array(journalViewModel.logsByDate.keys.sorted()), id: \.self) { date in
                Section(header: Text("\(Formatter.formatDate(date: date))")) {
                    
                    ForEach(journalViewModel.logsByDate[date] ?? [], id: \.self) { log in
                        VStack {
                            Text("\(log.habit ?? "")")
                            Text("\(log.seconds)")
                            Text("\(log.note ?? "")")
                        }

                    }
                    
                }
            }
            .listRowBackground(Color(.systemGray6))
            .navigationBarTitle("\(journalViewModel.habit) Log")
        }
        .onAppear(perform: {
            journalViewModel.fetchData()
        })
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView(habit: "Meditation")
    }
}
