//
//  ViewController.swift
//  StrikeIt
//
//  Created by Maha Habib on 22/12/2019.
//  Copyright © 2019 Maha Habib. All rights reserved.
//

import UIKit

class StrikeItViewController: UITableViewController {
    
    //Persisting Data Step 1
    
    let defaults = UserDefaults.standard
    
    var itemArray = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Persisting Data Step 3
        if let items = UserDefaults.standard.array(forKey: "StrikeItArray") as? [String] {
            itemArray = items
        }
          tableView.reloadData()
    }
    
    //MARK - TableView Datasource Methods
    
    //Counts the items in the array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    //appends the array to the table cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    //adding the checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //Persisting Data Step 2
            self.defaults.set(self.itemArray, forKey: "StrikeItArray")
            
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}

