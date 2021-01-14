//
//  NoteView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/10/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

struct NoteView: View {
    var note: Note
    
    init(note: Note) {
        self.note = note
    }
    
    var body: some View {
        Text(note.title ?? "")
        Text(note.text ?? "")
    }
}
//
//struct NoteView_Previews: PreviewProvider { static var previews: some View { NoteView(note: )
//    }
//}
