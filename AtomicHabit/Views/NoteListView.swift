//
//  NoteListView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/10/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var noteViewModel: NoteViewModel
    
    init(habit: String) {
        noteViewModel = NoteViewModel(habit: habit)
    }
    
    var body: some View {
        
        VStack{
            HStack {
                Text("Notes")
                Spacer()
                NavigationLink(destination: AddNoteView(noteViewModel: noteViewModel), label: {
                    Text("+")
                })
            }
            
            ForEach(noteViewModel.notes, id: \.self) { note in
                NoteView(note: note)
            }
            
        }
        .onAppear(perform: {
            noteViewModel.fetchData()
        })


    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(habit: "Meditation")
    }
}
