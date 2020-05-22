//
//  SQLiteCRUD.swift
//  CTS
//
//  Created by Keshav Gupta on 2020-05-18.
//  Copyright © 2020 Keshav Gupta. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteService{
    static private var db:OpaquePointer?
    static private let tableString = "CREATE TABLE IF NOT EXISTS CTS (key INTEGER PRIMARY KEY AUTOINCREMENT, APPID TEXT, timestamp TEXT)"
    static private let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("CTS.sqlite")
    static private let queryString = "INSERT INTO CTS (APPID, timestamp) VALUES (?, ?)"
    
    //Create database
    static func create(){
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_exec(db, tableString, nil, nil, nil) != SQLITE_OK {
            print("error creating table")
        }
    }
    
    //Read to array of appuser object
    static func read() -> [AppUser]?{
        self.create()
        
        let queryString = "SELECT * FROM CTS"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            print("error preparing insert")
        }
        
        var APPID:String = "", timeStamp:String = ""
        var key:Int32 = 0
        var tempUsers:[AppUser] = []
        while(sqlite3_step(stmt) == SQLITE_ROW){
            key = sqlite3_column_int(stmt, 0)
            APPID = String(cString: sqlite3_column_text(stmt, 1))
            timeStamp = String(cString: sqlite3_column_text(stmt, 2))
            
            tempUsers.append(AppUser(key: key, APPID: APPID, timeStamp: timeStamp))
            
        }
        
        return tempUsers
    }
    
    //Update table (add component)
    static func update(APPID:NSString, timestamp:Date){
        var stmt:OpaquePointer?
        let datefromatter = DateFormatter()
        datefromatter.dateStyle = .medium
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

        self.create()
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            print("error preparing insert")
        }
        
        if sqlite3_bind_text(stmt, 1, APPID.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            print("failure binding date")
        }
        
        if sqlite3_bind_text(stmt, 2, (datefromatter.string(from: timestamp) as NSString).utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            print("failure binding imagename")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            print("Could not Complete Insert")
        }
    }
    
    //Delete with its autoincrement value
    static func delete(key:Int32){
        self.create()
        
        let deleteStmt = "DELETE FROM CTS WHERE id = \(key)"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, deleteStmt, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) != SQLITE_DONE {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(stmt)
    }
    
    //Overloaded Delete for appid
    static func delete(APPID:String){
        self.create()
        
        let deleteStmt = "DELETE FROM CTS WHERE APPID = \(APPID)"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, deleteStmt, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) != SQLITE_DONE {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(stmt)
    }
}
