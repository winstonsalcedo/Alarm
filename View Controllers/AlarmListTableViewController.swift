//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by winston salcedo on 5/6/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  AlarmController.shared.alarms = AlarmController.shared.loadData
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? SwitchTableViewCell
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell?.alarm = alarm
        cell!.timeLabel.text = alarm.fireDateAsString
        cell?.nameLabel.text = alarm.name
        cell?.delegate = self as? SwitchTableViewCellDelegate
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmToDelete = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailCell", let  indexpath = tableView.indexPathForSelectedRow{
            let destinationVC = segue.destination as? AlarmDeltailTableViewController
            let alarm = AlarmController.shared.alarms[indexpath.row]
            destinationVC?.alarm = alarm
        }
    }
    
    
}

