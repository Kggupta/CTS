//
//  NotificationService.swift
//  CTS
//
//  Created by Keshav Gupta on 2020-05-29.
//  Copyright © 2020 Keshav Gupta. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationService{
    
    static let center = UNUserNotificationCenter.current()
    static var nFlag:Int?
    static var infected:[Int] = [0,1]
    
    static func setContent()-> UNMutableNotificationContent{
        nFlag = getStatus()
        let content = UNMutableNotificationContent()
        content.title = "Infection Update"
        content.body = "\(getEmoji(nFlag:nFlag!))"
        return content
    }
    
    //Randomly pick between infected or not. Override this
    static private func getStatus() -> Int{
        return infected.randomElement()!
    }
    
    static private func getEmoji(nFlag:Int) ->String{
        if nFlag == 1{
            return "😃"//Not infected
        }else{
            return "😢"//Infected
        }
    }
    
    static func scheduleNotif(){
        //10 seconds for testing purposes. Gives time for dev to leave the app. Wait a few seconds and the notification will pop up.
        let date = Date().addingTimeInterval(10)
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: setContent(), trigger: trigger)

        center.add(request) { (error) in
            //Completion handler upon added
        }
    }
}
