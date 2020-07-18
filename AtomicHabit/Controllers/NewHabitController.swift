//
//  NewHabitController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 6/28/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData

class NewHabitController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var categoryField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createHabit(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Habit", in: context)
        
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        let habitName = nameField.text
        newEntity.setValue(habitName, forKey: "name")
        
        do {
            try context.save()
            print("saved")
            
        } catch {
            print("Failed saving")
        }
        getData()
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Habit")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let name = data.value(forKey: "name") as! String
                print(name)
            }
            
        } catch {
            print("Failed!")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
