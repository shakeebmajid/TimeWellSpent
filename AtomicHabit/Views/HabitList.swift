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
    var body: some View {
        List {
            Text("Hello, World!")
        }
    }
}

@available(iOS 13, *)
struct HabitList_Previews: PreviewProvider {
    static var previews: some View {
        HabitList()
//            .environment(\.colorScheme, .dark)
    }
}
