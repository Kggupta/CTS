//
//  ViewController.swift
//  CTS
//
//  Created by Keshav Gupta on 2020-05-18.
//  Copyright © 2020 Keshav Gupta. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "APPID") == nil{
            UserDefaults.standard.set(AppUser.generateAnAPPID(), forKey: "APPID")
        }
        NotificationService.center.requestAuthorization(options:[.alert,.sound]) { (granted, error) in
            print("Granted: \(granted)")
        }
    }
    @IBAction func notifiy(_ sender: Any) {
        print("hello")
        NotificationService.scheduleNotif()
    }
}
