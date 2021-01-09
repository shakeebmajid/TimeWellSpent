//
//  IntervalSumController.swift
//  AtomicHabit
//
//  Created by Shakeeb Majid on 10/9/20.
//  Copyright © 2020 AtomicHabit. All rights reserved.
//

import UIKit

class IntervalSumController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var dates = [] as! [Date]
    var intervalSums = [] as! [Int]
    var habit: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let intervalsAndDates = TimeService.getAllWeekIntervalSums(habit: habit ?? "")
        dates = intervalsAndDates.0
        intervalSums = intervalsAndDates.1
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalSumCell", for: indexPath) as! IntervalSumCell
        
        let row = indexPath.row
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        cell.startDateLabel.text = df.string(from: dates[row])
        cell.intervalSumLabel.text = ("\(TimeService.formatTimeAbbreviated(seconds: intervalSums[row]))")
        
        
        return cell
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return intervalSums.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          return 1
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
