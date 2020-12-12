//
//  TimerController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 6/29/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit
import CoreData

class TimerController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weekTimeLabel: UILabel!
    @IBOutlet weak var dayTimeLabel: UILabel!
    
    var habit: String?
    var timer: Timer?
    var interval = 0
    var start = true
    var times: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = habit
        tableView.delegate = self
        tableView.dataSource = self
        
        times = TimeService.getIntervalsForCurrentDay(habit: habit!)
        tableView.reloadData()
        dayTimeLabel.text = "\(TimeService.formatTime(seconds: TimeService.sumTimeFromIntervals(intervals: times)))"
        weekTimeLabel.text = "\(TimeService.formatTime(seconds: TimeService.sumTimeFromDates(habit: habit!, startDate: Date().startOfWeek!, endDate: Date())))"
        
        // for going to background while a timer is running
        NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground(noti: )), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(noti: )), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    @objc func pauseWhenBackground(noti: Notification) {
        self.timer?.invalidate()
        let shared = UserDefaults.standard
        shared.set(Date(), forKey: "savedTime")
        print("Date when background: \(Date())")
    }
    
    @objc func willEnterForeground(noti: Notification) {
        if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
            let diffSeconds = getTimeDifference(startDate: savedDate)
            interval += diffSeconds
            timeLabel.text = TimeService.formatTime(seconds: interval)
            
        }
        startTimer()
    }
    func getTimeDifference(startDate: Date) -> Int {
        let timeDiff = Int(Date().timeIntervalSince(startDate))
        print("current date: \(Date())")
        print("time difference: \(timeDiff)")
        return timeDiff
        
    }
    @IBAction func toggleTimer(_ sender: Any) {
        if (start) {
            toggleButton.setTitle("Stop", for: .normal)
            startTimer()
            start = false
        } else {
            toggleButton.setTitle("Start", for: .normal)
            stopTimer()
            start = true
        }
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = Timer()
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        interval = 0
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "HH:mm:ss"
        
        timeLabel.text = formatter.string(from: Date(timeIntervalSinceReferenceDate: TimeInterval(interval)))
    }
    
    @objc func updateTimer() {
        interval = interval + 1
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "HH:mm:ss"
        
        timeLabel.text = formatter.string(from: Date(timeIntervalSinceReferenceDate: TimeInterval(interval)))
    }
    
    @IBAction func saveTime(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Interval", in: context)
        
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        let seconds = interval
        newEntity.setValue(seconds, forKey: "seconds")
        newEntity.setValue(habit, forKey: "habit")
        
        do {
            try context.save()
            print("saved")
            
        } catch {
            print("Failed saving")
        }
        times = TimeService.getIntervalsForCurrentDay(habit: habit!)
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
        let row = indexPath.row

        cell.lapLabel.text = "\(row)"
        cell.lapTimeLabel.text = TimeService.formatTime(seconds: times[row].value(forKey: "seconds") as! Int)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    


}

