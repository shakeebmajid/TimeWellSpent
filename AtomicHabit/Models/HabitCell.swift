//
//  HabitCell.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 6/28/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

class HabitCell: UITableViewCell {
    
    @IBOutlet weak var mondayBox: UIButton!
    @IBOutlet weak var tuesdayBox: UIButton!
    @IBOutlet weak var wednesdayBox: UIButton!
    @IBOutlet weak var thursdayBox: UIButton!
    @IBOutlet weak var fridayBox: UIButton!
    @IBOutlet weak var saturdayBox: UIButton!
    @IBOutlet weak var sundayBox: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
