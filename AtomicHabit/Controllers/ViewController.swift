//
//  ViewController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 5/8/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var habits: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        habits = HabitService.getHabits()
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitCell
        
        let row = indexPath.row
        
        let habit = habits[row] as! NSManagedObject
        let habitName = habit.value(forKey: "name") as! String
        cell.nameLabel.text = habitName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("about to segue")
        if segue.identifier == "toHabit" {
            let controller = segue.destination as! HabitController
            controller.habit = ((sender as! HabitCell).nameLabel?.text)!
        }
    }
    
}


