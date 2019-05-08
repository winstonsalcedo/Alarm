//
//  Alarm.swift
//  Alarm
//
//  Created by winston salcedo on 5/6/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit

class Alarm: Equatable, Codable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        if lhs.uuid == rhs.uuid {return true}
        
        return false
    }
    
    
    var fireDate: Date = Date()
    var name: String
    var isOn: Bool = false
    var uuid: String
    var fireDateAsString: String {
        get {
            let dateFormater = DateFormatter()
            dateFormater.dateStyle = .medium
            dateFormater.timeStyle = .short
            return dateFormater.string(from: fireDate)
        }
    }
    
    
    init(name: String, isOn: Bool, fireDate: Date, uuid: String = UUID().uuidString) {
        self.name = name
        self.isOn = isOn
        self.fireDate = fireDate
        self.uuid  = uuid
        
    }
    func toggleisOnFor(){
        
    }
    
}
