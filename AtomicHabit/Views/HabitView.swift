//
//  HabitView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/2/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct HabitView: View {
    @State var showForm = false
    var habit: String
    
    var body: some View {
        ScrollView {
            ZStack {
                
                VStack {
                    Toggle(isOn: $showForm) {
                        Text("Show welcome message")
                    }.padding()
                    
                    TimeView(habit: habit)
                    VStack(alignment: .leading) {
                        LineChartSectionView(habit: habit)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                    }
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .frame(height: 300)
                    
                    NavigationLink(destination: JournalView(habit: habit), label: {
                        Text("Logs")
                    })
                    
                    NoteListView(habit: habit)
                
                }
                .navigationBarTitle(habit)
                
                if showForm {
                    SubmitView(timeViewModel: TimeViewModel(habit: "habit"))
                        .background(Color(.clear))
                        .cornerRadius(20.0)
                        .aspectRatio(contentMode: .fit)
                        
                        .padding(.horizontal, 40)
                    
                }
                
            }
        }

    }
//                if showForm {
//                    Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
////                    VStack {
////                        SubmitView(timeViewModel: TimeViewModel(habit: habit))
////                        Button(action: {
////                            self.showForm.toggle()
////                        }) {
////                            Text("Close")
////                        }
////                    }
//                    SubmitView(timeViewModel: TimeViewModel(habit: habit))
//                        .aspectRatio(contentMode: .fit)
////                    .frame(width: 340, height: 340, alignment: .center)
//                    .background(Color.primary.colorInvert()).cornerRadius(15)
//
//                }

//        }.navigationBarTitle(habit)
}

@available(iOS 13.0.0, *)
struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HabitView(habit: "Meditation")
        }
    }
}
