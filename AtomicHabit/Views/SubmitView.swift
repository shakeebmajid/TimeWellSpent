//
//  SwiftUIView.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 1/2/21.
//  Copyright © 2021 AtomicHabit. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SubmitView: View {
    @ObservedObject var timeViewModel: TimeViewModel
    @State var minutes = 0
    @State var hours = 0
    @State var time = ""
    @State var showPicker = false
    @State var entryDate = Date()
    @State var note = "Add a Note"
    var body: some View {
        Form {
            DatePicker("Entry Date", selection: $entryDate, displayedComponents: .date)
            TextField (
                "\(hours) hours \(minutes) minutes",
                text : $time,
                onEditingChanged : { (changed) in                     withAnimation {                         showPicker.toggle()                     }                 }
            )
            if showPicker {
                GeometryReader {
                    geometry in HStack {
                        Spacer()
                        Picker (selection: $hours, label: Text("Favorite Framework"))
                        {
                            ForEach (0...24, id: \.self)
                            { hour in                                     Text("\(hour)")
                            }
                        }
                        .pickerStyle (WheelPickerStyle())
                        .fixedSize (horizontal: true, vertical: true)
                        .frame (
                            width : geometry.size.width / 4,
                            height : 160,
                            alignment : .center
                        )
                        .clipped ()
                        Text("h")
                            .fixedSize (horizontal: true, vertical: true)
                            .frame (
                                width : geometry.size.width / 8,
                                height : 160,
                                alignment : .center
                            )
                            .clipped ()
                        
                        Picker (
                            selection : $minutes,
                            label : Text ("Favorite Framework")
                        )
                        {
                            ForEach (0...60, id: \.self)
                            { minute in                                     Text("\(minute)")
                            }
                        }
                        .pickerStyle (WheelPickerStyle())
                        .fixedSize (horizontal: true, vertical: true)
                        .frame (
                            width : geometry.size.width / 4,
                            height : 160,
                            alignment : .center
                        )
                        .clipped ()
                        Text("m")
                            .fixedSize (horizontal: true, vertical: true)
                            .frame (
                                width : geometry.size.width / 8,
                                height : 160,
                                alignment : .center
                            )
                            .clipped ()
                        Spacer()
                    }
                }
                .frame (height: 160)
            }
            TextEditor(text: $note)
                .foregroundColor(self.note == "Add a Note" ? .gray : .primary)
                .onTapGesture {
                  if self.note == "Add a Note" {
                    self.note = ""
                  }
                }
            Button (
                action : {
                    if note == "Add a Note" {
                        note = ""
                    }
                    timeViewModel.submitTime(hours: hours, minutes: minutes, entryDate: entryDate, note: note)
                }
            )
            {                     Text("Submit Time")                                     }
        }
        .navigationBarTitle ("\(timeViewModel.habit) Entry")

    }

}

@available(iOS 13.0, *)
struct SubmitView_Previews: PreviewProvider {
    static var previews: some View {
        
        SubmitView(timeViewModel: TimeViewModel(habit: "Meditation"))
    }
}
