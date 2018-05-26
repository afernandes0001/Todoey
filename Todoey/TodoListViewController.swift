//
//  ViewController.swift
//  Todoey
//
//  Created by Andre Fernandes on 20/05/2018.
//  Copyright © 2018 Andre Fernandes. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggs","Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //STEP 12
        of let items = itemArray = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - Step 1 - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // STEP 1
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Step 2 - Tableview Delegate Methods
   
        //STEP 2
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //STEP 3
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            // STEP 10
            self.itemArray.append(textField.text!)
            
            // STEP 11
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // STEP 10
            self.tableView.reloadData()
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
}

