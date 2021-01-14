//
//  AddNoteView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/10/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

struct AddNoteView: View {
    @State var title = ""
    @State var text = "Body"
    @ObservedObject var noteViewModel: NoteViewModel
    var body: some View {
        Form {
            TextField("title", text: $title)
           
            TextEditor(text: $text)
                .foregroundColor(self.text == "Body" ? .gray : .primary)
                .onTapGesture {
                  if self.text == "Body" {
                    self.text = ""
                  }
                }
            Button (
                action : {
                    if text == "Body" {
                        text = ""
                    }
                    noteViewModel.addNote(title: title, text: text)
                }
            )
            {
                Text("Add Note")
            }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(noteViewModel: NoteViewModel(habit: "Meditation"))
    }
}
