//
//  ViewController.swift
//  SQLite
//
//  Created by Prachi on 21/07/21.
//

import UIKit
import SQLite3


struct Person {
   var Id: Int
    var Name : String
    var Age : Int
    var PhoneNo : String
    
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var PhoneNo: UILabel!
    @IBOutlet weak var Age: UILabel!
    @IBOutlet weak var Id: UILabel!
}
    
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return persons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.self.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        cell?.Id.text = String(persons[indexPath.row].Id)
        cell?.Name.text = persons[indexPath.row].Name
        cell?.Age.text = String(persons[indexPath.row].Age)
        cell?.PhoneNo.text = persons[indexPath.row].PhoneNo
        return cell ?? TableViewCell()
    }
    
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        if let vc=storyboard?.instantiateViewController(identifier: "ViewController2") as? ViewController2 {

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    @IBOutlet weak var TableView: UITableView!
    
    var persons = [Person]()
    var dbManager = DBManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource  = self
        
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        
        if let personsTo = dbManager.readPersonData(){
            persons = personsTo
            TableView.reloadData()
            
        }
        
    }


    
    
}




