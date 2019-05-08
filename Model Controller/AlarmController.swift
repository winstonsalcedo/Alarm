//
//  AlarmController.swift
//  Alarm
//
//  Created by winston salcedo on 5/6/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications (for alarm: Alarm)
    func cancelUserNotifications (for alarm: Alarm)
}

class AlarmController {
    
    // Singleton
    static var shared = AlarmController()

    // Source of Truth
    
    var alarm: Alarm?
    
    var alarms = [Alarm]()
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(name: name, isOn: enabled, fireDate: fireDate)
        alarms.append(newAlarm)
        
        saveAlarm()
        
    }
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool){
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isOn = enabled
        
        saveAlarm()
    }
    func delete(alarm: Alarm){
        if let index = AlarmController.shared.alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
            
            saveAlarm()
        }
        
    }
    func toggleEnabled(for alarm: Alarm){
        if alarm.isOn == !alarm.isOn {
            alarm.toggleisOnFor()
            cancelUserNotifications(for: alarm)
        }else {
            alarm.isOn = true
            self.scheduleUserNotifications(for: alarm)
        }
        
    }
    func fileURL() -> URL {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileurl = urls.first!.appendingPathComponent("alarm.json")
        
        return fileurl
    }
    func saveAlarm() {
        let jsonEncoder = JSONEncoder()
        
        do{
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileURL())
        }catch{
            print("The following error was encountered \(error.localizedDescription)" )
            
            return 
        }
        func loadAlarms() -> [Alarm]{
            let jsonDecoder = JSONDecoder()
            
            do {
                let urls = fileURL()
                let data = try Data(contentsOf: urls)
                let alarms = try jsonDecoder.decode([Alarm].self, from: data)
                return alarms
            }
            catch {
                print("there was an error while loading your file \(error.localizedDescription)")
            }
            return []
        }
       
    }
    
}
extension AlarmController : AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Time is Up!!!"
        content.body = "Coffee break is over..."
        content.sound = UNNotificationSound.defaultCritical
        let dateComponents = Calendar.current.dateComponents([.minute, .second, .hour], from: alarm.fireDate)
        let calendar = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: true)
        
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    
}
