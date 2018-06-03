//
//  ViewController.swift
//  Todoey
//
//  Created by Andre Fernandes on 20/05/2018.
//  Copyright © 2018 Andre Fernandes. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

//    var itemArray = ["Find Mike","Buy Eggs","Destroy Demogorgon"]
    
    // STEP 14
    var itemArray = [Item]()
    // STEP 21 - Create
    // STEP 24 - moved to Global var
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    // STEP 22 - Remove UserDefaults as this is for very basic actions
//        let defaults = UserDefaults.standard
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(dataFilePath)

        //STEP 13
        // STEP 29 - Removed
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        self.itemArray.append(newItem)
// 
//        let newItem2 = Item()
//        newItem2.title = "Find Andre"
//        self.itemArray.append(newItem2)

        
        //STEP 12 - Create
        // STEP 25 - Removed this session
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        // STEP 28
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - Step 1 - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // STEP 1
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        // STEP 19 - The idea here is just simplify coding
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        // STEP 20 - Converted IF to Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
//        if itemArray[indexPath.row].done == true {
//                cell.accessoryType = .checkmark
//        } else {
//                cell.accessoryType = .none
//        }
        
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Step 2 - Tableview Delegate Methods
   
        //STEP 2
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        // STEP 18
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()

        // STEP 16
//        if itemArray[indexPath.row].done == false {
//           itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        // STEP 17
        // STEP 26 - Remove line below
//        tableView.reloadData()
        
        //STEP 3
        // STEP 17 - commented STEP 3
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        //STEP 2
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    //MARK - Step 4 - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // STEP 8 - Create a VAR that be be used anywhere within the method
        var textField = UITextField()
        
        // STEP 5
        let alert = UIAlertController(title: "Add New Todoey Item", message: "Message bar", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert

            // STEP 15
            let newItem = Item()
            newItem.title = textField.text!
            
            // STEP 10
//            self.itemArray.append(textField.text!)
       
            // STEP 15
            self.itemArray.append(newItem)
            
            // STEP 11
            // STEP 23 - Remove & add func saveItems
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
            
            // STEP 10 - Creation (check step 27)
//            self.tableView.reloadData()
        }
        
        // STEP 7
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        // STEP 9 - Use VAR from STEP 8
            textField = alertTextField
        }
        
        // STEP 6
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

// MARK - Model Manipulation Methods - STEP 27

func saveItems() {
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    } catch {
        print("Error enconding Array, \(error)")
    }
    tableView.reloadData()

    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}

