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
    
    //We Made a class "Item" that contains a String & Bool properties
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hard coding the Array into the Cells
        let newItem = Item()
        newItem.title = "Simba"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "is"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "a Blimpa"
        itemArray.append(newItem3)
        
        //Persisting Data Step 3
        if let items = UserDefaults.standard.array(forKey: "StrikeItArray") as? [Item] {
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    //adding the checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let the item be the opposite Bool
        let item = itemArray[indexPath.row]
        item.done = !item.done
        
        tableView.reloadData()
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //creating a new item using the class Item and setting it's title property
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //Persisting Data Step 2
            self.defaults.set(self.itemArray, forKey: "StrikeItArray")
            
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

