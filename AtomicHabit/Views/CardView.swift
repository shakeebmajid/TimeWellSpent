//
//  CardView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/2/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct CardView: View {
    var habit: String
    var body: some View {
        

        VStack {
//            NavigationLink(destination: Storyboard(habit: habit)) {
            NavigationLink(destination: HabitView(habit: habit)) {
                
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
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(habit: "Meditation")
    }
}
