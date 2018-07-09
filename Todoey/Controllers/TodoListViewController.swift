//
//  ViewController.swift
//  Todoey
//
//  Created by Andre Fernandes on 20/05/2018.
//  Copyright © 2018 Andre Fernandes. All rights reserved.
//

import UIKit
//STEP 34 - Import CoreData
import CoreData

class TodoListViewController: UITableViewController {

//    var itemArray = ["Find Mike","Buy Eggs","Destroy Demogorgon"]
    
    // STEP 14
    var itemArray = [Item]()
    // STEP 21 - Create
    // STEP 24 - moved to Global var
    
    //STEP 35 - Commented line below
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    // STEP 43 - Var for the selected Category
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    //STEP 32 - Move to Global session
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // STEP 22 - Remove UserDefaults as this is for very basic actions
//        let defaults = UserDefaults.standard
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //step 39 - Searchbar
//        searchBar.delegate = self

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
        // STEP 28 - STEP44 - moved loadItem to step 43
//        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - STEP 30 - remove Item.swift
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
//        print(itemArray[indexPath.row])
        

        //STEP 37 - Updating information
//        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        //STEP 38 - If I wanted to remove an item - First I need to remove from the Context and then delete it
//         context.delete(itemArray[indexPath.row])
//         itemArray.remove(at: indexPath.row)
        
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

            // STEP 15 - STEP 31 - Changed to CoreData - As context is needed more than once, it was move to global variable
//            let newItem = Item()
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            //STEP 34 - Setting done to false
            newItem.done = false
            
            // STEP 45 - Added parent Category
            newItem.parentCategory = self.selectedCategory
            
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
        //STEP 33 - Saving Context
        try context.save()
        
        //STEP 31 - remove code below
//        let data = try encoder.encode(itemArray)
//        try data.write(to: dataFilePath!)
    } catch {
//        print("Error enconding Array, \(error)")
        print("Error saving context \(error)")
    }
    tableView.reloadData()

    }
    
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }
//    }
//
    // STEP 36 - Implemented "Read" the database
    
//    func loadItems() {
    
    //STEP 39 - Take a parameter
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        // STEP 46 - Filter per Category
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
      
        // STEP 48 - Added Compound Predicate
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        //        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
        
        //STEP 40 - Line below is no longer needed as it is informed as a parameter
        //        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}

// step 38 - Added seachbar
//MARK: Searchbar methods

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
        //        tableView.reloadData()

        // STEP 47 - added predicate as parameter
        loadItems(with: request, predicate: predicate)
        
    }
 
    //STEP 41 - Loadl all items
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
       
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
  
        }
  
    }
}

