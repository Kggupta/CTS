//
//  AppUser.swift
//  CTS
//
//  Created by Keshav Gupta on 2020-05-18.
//  Copyright © 2020 Keshav Gupta. All rights reserved.
//

import Foundation

class AppUser{
    //Parameters
    var key:Int32
    var APPID:String
    var timeStamp:Date
    
    //Initialize values for sqlite
    init(key:Int32,APPID:String,timeStamp:String){
        self.key = key
        self.APPID = APPID
        
        let datefromatter = DateFormatter()
        datefromatter.dateStyle = .medium
        self.timeStamp = datefromatter.date(from: timeStamp)!
    }
    
    //Generating a unique appID to be overloaded
    static func generateAnAPPID() ->String{
        return UUID().uuidString
    }
    
    //Setting the app ID to user defaults (just used for persistance and testing. this can be removed)
    static func initID(){
        if UserDefaults.standard.object(forKey: "APPID") == nil{
            UserDefaults.standard.set(AppUser.generateAnAPPID(), forKey: "APPID")
        }
    }
}
