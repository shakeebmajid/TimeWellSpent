//
//  HabitCell.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 6/28/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData

class HabitCell: UITableViewCell {
    
    @IBOutlet weak var mondayBox: UIButton!
    @IBOutlet weak var tuesdayBox: UIButton!
    @IBOutlet weak var wednesdayBox: UIButton!
    @IBOutlet weak var thursdayBox: UIButton!
    @IBOutlet weak var fridayBox: UIButton!
    @IBOutlet weak var saturdayBox: UIButton!
    @IBOutlet weak var sundayBox: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var completions = [] as [NSManagedObject]
    
    var someDict : [UIButton:NSManagedObject] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func initializeCompletions() {
        completions = CompletionService.getCompletionsForWeek(habit: nameLabel.text!)
        someDict = [mondayBox:completions[0], tuesdayBox: completions[1], wednesdayBox: completions[2], thursdayBox: completions[3], fridayBox: completions[4], saturdayBox: completions[5], sundayBox: completions[6]]
        
        for (button, completion) in someDict {
            if completion.value(forKey: "complete") as! Bool {
                button.backgroundColor = UIColor.green
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func toggleCompletion(_ sender: Any) {
        let button = sender as! UIButton
        
        
        let completion = someDict[button]
        
        if (completion?.value(forKey: "complete") as! Bool) {
            completion?.setValue(false, forKey: "complete")
            button.backgroundColor = UIColor.white
        } else {
            completion?.setValue(true, forKey: "complete")
            button.backgroundColor = UIColor.green

        }
        CompletionService.saveCompletion()
        
    }
    
}
