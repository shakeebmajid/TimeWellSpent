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
                Color(.systemBackground)
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

@available(iOS 13, *)
struct CardView: View {
    var habit: String
    var body: some View {
        

        VStack {
            NavigationLink(destination: Storyboard(habit: habit)) {
                
                HStack(alignment: .center) {
                    Text(habit)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }

        }

        .padding(.horizontal, 5)
        .background(Color(.systemOrange))
        .cornerRadius(10)
        .shadow(color: Color(UIColor.black.withAlphaComponent(0.05)), radius: 15, x: 0, y: 3)
    }
}

@available(iOS 13, *)
struct Storyboard : UIViewControllerRepresentable {
    
    var habit: String?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Storyboard>) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "HabitController") as HabitController
        controller.habit = habit
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Storyboard>) {
    
    }
}
