//
//  AlarmDeltailTableViewController.swift
//  Alarm
//
//  Created by winston salcedo on 5/6/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit


class AlarmDeltailTableViewController: UITableViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmTextField: UITextField!
    @IBOutlet weak var alarmEnabledBtn: UIButton!
    
    
    
  //  let alarmIsOn = alarm.enabled
    
    var alarm: Alarm? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    var alarmIsOn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let firedDate = datePicker.date, enabled = alarmIsOn
        guard let name = alarmTextField.text, !name.isEmpty else { return }
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: firedDate, name: name, enabled: enabled)
        }else {
            AlarmController.shared.addAlarm(fireDate: firedDate, name: name, enabled: enabled)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func datePicker(_ sender: Any) {
       
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        if alarm?.isOn == true {
            alarmEnabledBtn.backgroundColor = #colorLiteral(red: 1, green: 0.04666775465, blue: 0, alpha: 1)
            alarmEnabledBtn.setTitle("Alarm Off", for: .normal)
        }else {
            self.title = "Add an Alarm"
            self.alarmEnabledBtn.setTitle("Off", for: .normal)
        }
       
        updateViews()
    }

    private func updateViews() {
        if let alarm = alarm {
            alarmTextField.text = alarm.name
            datePicker.date = alarm.fireDate
            self.title = "Edit Alarm"
            
        }
        
    }
}
