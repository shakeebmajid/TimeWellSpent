//
//  HabitList.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 12/30/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct HabitList: View {
    var categories: [String]
    var habitsByCategories: [String: [String]]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                List {
                    
                    ForEach(categories, id: \.self) { category in
                        Section(header: Text(category)) {
                            
                            ForEach(habitsByCategories[category] ?? [], id: \.self) { habit in
                                    CardView(habit: habit)

                            }
                            
                        }
                    }
                    .listRowBackground(Color(.systemGray6))
                }
                .navigationBarTitle("Habit List")
            }
        }
    }
}

func doAction() {
    print("doAction")
}
@available(iOS 13, *)
struct HabitList_Previews: PreviewProvider {
    static var previews: some View {
        HabitList(categories: ["Health", "Learning"], habitsByCategories: ["Health": ["Soccer", "Meditation"], "Learning": ["Japanese", "Reading"]])
//            .environment(\.colorScheme, .dark)
    }
}

@available(iOS 13, *)
struct CardView: View {
    var habit: String
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                Text(habit)
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
        }

        .padding(.horizontal, 5)
        .background(Color(.systemOrange))
        .cornerRadius(10)
        .shadow(color: Color(UIColor.black.withAlphaComponent(0.05)), radius: 15, x: 0, y: 3)
    }
}
