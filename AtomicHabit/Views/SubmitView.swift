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
    var body: some View {
        Form {
            TextField (
                "\(hours) hours \(minutes) minutes",
                text : $time,
                onEditingChanged : { (changed) in                     withAnimation {                         showPicker.toggle()                     }                 }
            )
            if showPicker {
                GeometryReader {
                    geometry in HStack {
                        Picker (selection: $hours, label: Text("Favorite Framework"))
                        {
                            ForEach (0...24, id: \.self)
                            { hour in                                     Text("\(hour) h")                                 }
                        }
                        .pickerStyle (WheelPickerStyle())
                        .fixedSize (horizontal: true, vertical: true)
                        .frame (
                            width : geometry.size.width / 2,
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
                            { minute in                                     Text("\(minute) m")                                 }
                        }
                        .pickerStyle (WheelPickerStyle())
                        .fixedSize (horizontal: true, vertical: true)
                        .frame (
                            width : geometry.size.width / 2,
                            height : 160,
                            alignment : .center
                        )
                        .clipped ()
                    }
                }
                .frame (height: 160)
            }
            Button (
                action : {
                    timeViewModel.submitTime(hours: hours, minutes: minutes)
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
