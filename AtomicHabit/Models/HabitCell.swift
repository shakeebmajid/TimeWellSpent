//
//  HabitCell.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 6/28/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

class HabitCell: UITableViewCell {
    
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
