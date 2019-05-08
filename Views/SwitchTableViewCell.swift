//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by winston salcedo on 5/6/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellswitchValueChanged(cell: SwitchTableViewCell)
    
}
class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet{
            
            updateViews()
        }
    }
    @IBAction func switchValueChanged(_sender: Any) {
        delegate?.switchCellswitchValueChanged(cell: self)
    }
    
    
    func updateViews() {
        guard let enabled = alarm?.isOn else { return}
        timeLabel.text = alarm?.fireDateAsString
        nameLabel.text = alarm?.name
        alarmSwitch.isOn = enabled
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
