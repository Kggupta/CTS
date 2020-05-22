//
//  AppUser.swift
//  CTS
//
//  Created by Keshav Gupta on 2020-05-18.
//  Copyright © 2020 Keshav Gupta. All rights reserved.
//

import Foundation

class AppUser{
    var key:Int32
    var APPID:String
    var timeStamp:Date
    
    init(key:Int32,APPID:String,timeStamp:String){
        self.key = key
        self.APPID = APPID
        
        let datefromatter = DateFormatter()
        datefromatter.dateStyle = .medium
        self.timeStamp = datefromatter.date(from: timeStamp)!
    }
}
