//
//  ViewController.swift
//  StrikeIt
//
//  Created by Maha Habib on 22/12/2019.
//  Copyright © 2019 Maha Habib. All rights reserved.
//

import UIKit
//Encoding Data with Core Data Step 1
import CoreData

class StrikeItViewController: UITableViewController {
    
    //We Made a class "Item" that contains a String & Bool properties
    var itemArray = [Item]()
    
    //configuring CoreData - Create
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
    
    //MARK: - TableView Delegate Methods
    
    //adding the checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let the item be the opposite Bool
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        //Saving Data to the context
        saveItems()
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //configuring CoreData
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //Encoding Data with Core Data Step 3
            newItem.done = false
            
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
    //MARK: - Model Manipulation Methods
    
    //Encoding Data with Core Data Step 2
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving contexts \(error)")
        }
        tableView.reloadData()
    }
    
    //Reading Data from Core Data - Read in CURD
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from Context \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Search Bar Methods

extension StrikeItViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //Creating a New request
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        print(searchBar.text!)
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        //Pass the request over the loaditems function
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
