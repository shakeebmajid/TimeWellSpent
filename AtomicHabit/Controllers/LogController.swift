//
//  LogController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/19/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData

class LogController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var habit: String?
    var notes = [] as! [NSManagedObject]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        notes = NoteService.getNotes(habit: habit!)
        tableView.reloadData()
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          return 1
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
      
        let row = indexPath.row
        cell.noteLabel.text = notes[row].value(forKey: "text") as! String
        cell.dateLabel.text = "\(notes[row].value(forKey: "createdAt") as! Date)"
        return cell
    }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return notes.count
      }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! NewNoteController
        
        destination.habit = habit!
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
