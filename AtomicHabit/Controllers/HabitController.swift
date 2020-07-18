//
//  HabitController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/14/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData

class HabitController: UIViewController {
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    var habit: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = habit!
        
    }
    
    @IBAction func submitTime(_ sender: Any) {
        if !timeTextField.text!.isEmpty {
            let seconds = Int(timeTextField.text!)! * 60
            timeTextField.text = ""
            saveTime(seconds: seconds)
        }
        
    }
    
    func saveTime(seconds: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
               let entity = NSEntityDescription.entity(forEntityName: "Interval", in: context)
               
               let newEntity = NSManagedObject(entity: entity!, insertInto: context)
               newEntity.setValue(seconds, forKey: "seconds")
               newEntity.setValue(habit, forKey: "habit")
               
               do {
                   try context.save()
                   print("saved")
                   
               } catch {
                   print("Failed saving")
               }
    }
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTimer" {
            let controller = segue.destination as! TimerController
            controller.habit = habit!
        }
        
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
    }
    

}
