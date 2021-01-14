//
//  NoteViewModel.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/10/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import Foundation


class NoteViewModel: ObservableObject {
    
    @Published var notes = [Note]()
    var habit: String
    
    init(habit: String) {
        self.habit = habit
    }
    
    func addNote(title: String, text: String) {
        NoteService.saveNote(habit: habit, title: title, text: text)
    }
    
    func fetchData() {
        notes = NoteService.getNotes(habit: habit)
    }
    
    
    
    
}
