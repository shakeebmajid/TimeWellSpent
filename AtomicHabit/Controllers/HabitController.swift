//
//  HabitController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 7/14/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData
import Charts

class HabitController: UIViewController {
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var weekTimeLabel: UILabel!
    @IBOutlet weak var monthTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var addNoteButton: StandardButton!
    @IBOutlet weak var timeLogsButton: StandardButton!
    @IBOutlet weak var pieChartButton: StandardButton!
    var habit: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = habit!
        
        // retrieves the times for day, week, month, all
        setTimeLabels()
    }
    
    func setTimeLabels() {
        // total time accumulated for habit
        let totalTime = TimeService.sumAllIntervals(habit: habit!)
        totalTimeLabel.text = ("\(TimeService.formatTimeAbbreviated(seconds: totalTime))")
        
        let dayTime = TimeService.sumIntervalsForCurrentDay(habit: habit!)
        dayTimeLabel.text = ("\(TimeService.formatTimeAbbreviated(seconds: dayTime))")

        let weekTime = TimeService.sumIntervalsForCurrentWeek(habit: habit!)
        weekTimeLabel.text = ("\(TimeService.formatTimeAbbreviated(seconds: weekTime))")
        
        let monthTime = TimeService.sumIntervalsForCurrentMonth(habit: habit!)
        monthTimeLabel.text = ("\(TimeService.formatTimeAbbreviated(seconds: monthTime))")
    }
    
    
    @IBAction func submitTime(_ sender: Any) {
//        if !timeTextField.text!.isEmpty {
//            let seconds = Int(timeTextField.text!)! * 60
//            timeTextField.text = ""
//            TimeService.saveTime(habit: habit!, seconds: seconds)
//        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTimer" {
            let controller = segue.destination as! TimerController
            controller.habit = habit!
        } else if segue.identifier == "toLog" {
            let destination = segue.destination as! LogController
            
            destination.habit = habit!
        } else if segue.identifier == "toIntervalSums" {
            let destination = segue.destination as! IntervalSumController
            
            destination.habit = habit!
        }
        
    }
}

extension Date {
    func changeDays(by days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}




