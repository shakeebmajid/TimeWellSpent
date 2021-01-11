//
//  NewNoteController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/19/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

class NewNoteController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var habit: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func onSubmit(_ sender: Any) {
//        NoteService.saveNote(habit: habit!, text: textView.text)
//        
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
