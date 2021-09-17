//
//  ViewController2.swift
//  SQLite
//
//  Created by Prachi on 28/07/21.
//

import UIKit

class ViewController2: UIViewController {
    var dbManager = DBManager()
    
    @IBOutlet weak var NameText: UITextField!
    
    @IBOutlet weak var AgeText: UITextField!
        @IBOutlet weak var PhoneNo: UITextField!
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()

          
        }
    
    @IBAction func Save(_ sender: UIButton) {
        guard let name = NameText.text, let age = AgeText.text, let phone = PhoneNo.text else {
            return
        }
        dbManager.insert(IName: name, IAge: Int(age) ?? 0, IPhone: phone)
        
        

        navigationController?.popViewController(animated: true)
    }
        
    }
    

    



