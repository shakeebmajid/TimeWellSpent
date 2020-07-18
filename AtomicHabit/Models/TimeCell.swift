//
//  TimeCell.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/3/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {
    @IBOutlet weak var lapTimeLabel: UILabel!
    @IBOutlet weak var lapLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
