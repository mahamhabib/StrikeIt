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
    //    let defaults = UserDefaults.standard
    
    //Encoding Data with NSCoder Step 1
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //We Made a class "Item" that contains a String & Bool properties
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath)
        
        //Persisting Data Step 3
        //        if let items = UserDefaults.standard.array(forKey: "StrikeItArray") as? [Item] {
        //            itemArray = items
        //        }
        
        tableView.reloadData()
        loadItems()
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
        //Encoding Data with NSCoder Step 3
        saveItems()
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
            //Encoding Data with NSCoder Step 3
            self.saveItems()
            //Persisting Data Step 2
            //            self.defaults.set(self.itemArray, forKey: "StrikeItArray")
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    //MARK - Model Manipulation Methods
    
    //Encoding Data with NSCoder Step 2
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error")
            }
        }
        
    }
    
    
}

