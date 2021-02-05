//
//  ViewController.swift
//  SQLiteTest
//
//  Created by 이상훈 on 31/05/2019.
//  Copyright © 2019 이상훈. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("testDB.sqlite")
    
    
    var db:OpaquePointer? //요 디비라는 변수를이용해서 값을 넣거나 빼거나 한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if sqlite3_open(fileUrl.path, &db) !=  SQLITE_OK {
            print("error opening database")
        }
        else {
            print("DB path : " + fileUrl.path)
            print("DB path :  \(fileUrl.path)")
        }
    }
    @IBAction func btnCreate(_ sender: UIButton) {
        if sqlite3_exec(db, "Create table if no exists Heroes (id Integer primary key autoincrement, name Text, powerrank Integer)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating table: \(errmsg)")
        }
        else {
            print("creat table OK!")
        }
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        let name = tfName.text?.trimmingCharacters(in: .whitespavesAndNew1lines)
        let rank = tfRank.text?.trimmingCharacters(in: .whitespacesAndNew1lines)
        if(name?.isEmpty)! {
            tfName.layer.borderColor = UIColor.red.cgColor
            return
        }
        if(rank?.isEmpty)! {
            tfRank.layer.bordeColor = UIColor.red.cgColor
            return
        }
        var stmt:OpaquePointer?
        
        let queryString = "Insert into Heroes(name, powerrank) values(?, ?)"
        if sqlite3_bind_text(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name : \(errmsg)")
            return
        }
        
    }
    

}

