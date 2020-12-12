//
//  IntervalSumCell.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 10/9/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

class IntervalSumCell: UITableViewCell {
    @IBOutlet weak var intervalSumLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
