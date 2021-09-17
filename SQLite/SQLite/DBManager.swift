//
//  DBManager.swift
//  SQLite
//
//  Created by Prachi on 27/07/21.
//

import UIKit
import SQLite3

class DBManager {

    let dbPath = try? (FileManager.default .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("PersonData.sqlite").path)
    var db: OpaquePointer?
    
    let personTable = "Person"

    init() {
        openDataBase()
        createTable()
       // insert(IName: "", IAge: 0, IPhone: "")
       // readPersonData()
        
     
    }
    
    func openDataBase()-> OpaquePointer? {
        var db: OpaquePointer?
//        guard let dbPath = dbPath else {
//            print("dbPath is nil ")
//            return nil
   //     }
        if sqlite3_open(self.dbPath, &db) == SQLITE_OK {
            print("Sucessfully Open DataBase \(dbPath)")
            self.db = db
        } else{
            print("Can't Open Data Base")
        }
      return db
    }

    func createTable(){
        let createTableString = " CREATE TABLE \(personTable) (id Int primary key autoincrement, name char(50),age Int,phoneNo char(10));"
        // 1
        var createTableStatement: OpaquePointer?
        
        // 2
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("\nTable Created")
            }
        else{
                print("Contract table Not created ")
            }
        }
        else {
            print("\nCREATE TABLE statement is not prepared.")
          }
        // 4
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(IName:String,IAge:Int,IPhone:String){
        let insertStatementString = "INSERT INTO \(personTable) (id, name, age, phoneNo) VALUES (?, ?, ?, ?);"
        var createStatment: OpaquePointer?
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &createStatment, nil) == SQLITE_OK {
            //let Id:Int32 = 1
            let name = IName as NSString
            let age = Int32 (IAge)
            let phoneNo = IPhone as NSString
            
            // 2
            
            sqlite3_bind_text(createStatment, 2, name.utf8String, -1, nil)
            sqlite3_bind_int(createStatment, 3, age)
            sqlite3_bind_text(createStatment, 4, phoneNo.utf8String, -1, nil)
            // 4
           if sqlite3_step(createStatment) == SQLITE_OK {
                print("Successfuly Inserted row")
            }
            else {
                print("Could not insert row.")
            }
        }
          else {
                print("INSERT statement is not prepared.")
        }
        // 5
        //sqlite3_reset(createStatment)
        sqlite3_finalize(createStatment)
    }
    
    
    func readPersonData ()-> [Person]?{
        var arr = [Person]()
        let readQuery = "SELECT * FROM \(personTable)"
        var readPointer : OpaquePointer?
        
        if sqlite3_prepare_v2(db, readQuery, -1, &readPointer, nil) == SQLITE_OK {
            
            while (sqlite3_step(readPointer) == SQLITE_ROW) {
                
                let id = sqlite3_column_int(readPointer, 0)
                
                guard let col1 = sqlite3_column_text(readPointer, 1) else {
                    print("Read query result for col1 is nil")
                    return nil
                }
                let name = String(cString: col1)
                
                let age = sqlite3_column_int(readPointer, 2)
                
                guard let col3 = sqlite3_column_text(readPointer, 3) else {
                    print("Read query result for col2 is nil ")
                    return nil
                }
                let phoneno = String(cString: col3)
                
                arr.append(Person(Id: Int(id), Name: name, Age: Int(age), PhoneNo: phoneno))
            }
            
        } else {
            let  errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        
        sqlite3_finalize(readPointer)
        return arr
    }
    
    func closeDB(){
        sqlite3_close(db)
    }
                
                }





