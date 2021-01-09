//
//  HabitList.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 12/30/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct HabitListView: View {
    
    @ObservedObject private var habitsViewModel = HabitsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
//                Color(.systemBackground)
                List {
                    ForEach(Array(habitsViewModel.habitsByCategory.keys), id: \.self) { category in
                        Section(header: Text(category)) {
                            
                            ForEach(habitsViewModel.habitsByCategory[category] ?? [], id: \.self) { habit in
                                CardView(habit: habit.name ?? "")

                            }
                            
                        }
                    }
                    .listRowBackground(Color(.systemGray6))
                }
                .onAppear() {
                    self.habitsViewModel.fetchData()
                }
                .navigationBarTitle("My Habits")
                .navigationBarItems(
                      trailing: Button(action: {}, label: {
                         NavigationLink(destination: Storyboard()) {
                              Text("+")
                         }
                      }))

            }
        }
    }
}

func doAction() {
    print("doAction")
}
@available(iOS 13, *)
struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitListView()
//            .environment(\.colorScheme, .dark)
    }
}
