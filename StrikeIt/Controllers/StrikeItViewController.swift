//
//  ViewController.swift
//  StrikeIt
//
//  Created by Maha Habib on 22/12/2019.
//  Copyright © 2019 Maha Habib. All rights reserved.
//

import UIKit
//Encoding Data with Core Data Step 1
import RealmSwift

class StrikeItViewController: UITableViewController {
    
// we intialize Realm
    
    let realm = try! Realm()
    var todoItems: Results<RealmItem>?

    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.reloadData()
    }
    
    //MARK: - TableView Datasource Methods
    
    //Counts the items in the array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //appends the array to the table cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            //Ternary Operator ==>
            //value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added Yet"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    //adding the checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("error updating done to Items \(error)")
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = RealmItem()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("error appending the items \(error)")
                }
                
            }
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Model Manipulation Methods
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title")
//        , ascending: true)
        tableView.reloadData()
        
        }
    }
    //MARK: - Search Bar Methods

    extension StrikeItViewController: UISearchBarDelegate {

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            todoItems = todoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            
            tableView.reloadData()
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



