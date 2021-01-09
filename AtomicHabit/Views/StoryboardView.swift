//
//  StoryboardView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/2/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
struct Storyboard : UIViewControllerRepresentable {
    
    var habit: String?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Storyboard>) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let controller = storyboard.instantiateViewController(identifier: "HabitController") as HabitController
        let controller = storyboard.instantiateViewController(identifier: "NewHabitController") as NewHabitController
//        controller.habit = habit
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Storyboard>) {
    
    }
}
