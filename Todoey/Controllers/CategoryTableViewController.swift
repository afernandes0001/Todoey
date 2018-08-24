//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Andre Fernandes on 10/06/18.
//  Copyright © 2018 Andre Fernandes. All rights reserved.
//

// STEP 41 - Category Screen creation!

import UIKit
// STEP 63 - Remove CoreData and add Realm
import CoreData
import RealmSwift


class CategoryTableViewController: UITableViewController {

   
    // STEP 62
    let realm = try! Realm()
        // STEP 71 - Changed from array to Results type
//    var categories = [Category]()
    var categories: Results<Category>?

    // STEP 68 - removed line below
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
 
        loadCategories()
        
    }

    //MARK - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoCategoryCell")
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // updated line below with ?? and added ? after categories
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // somente vai retornar valor se categories for diferente de nil. o ?? é a condição caso seja nil
        return categories?.count ?? 1
        
    }
    
    
    //MARK - Data Manipulation Methods

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        saveCategories()
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    // STEP 67 - Changed func name
//    func saveCategories()
    func save(category: Category) {
//        let encoder = PropertyListEncoder()
        
        do {
            // STEP 66 Removed context save and add realm save
//            try context.save()
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
        
    }
    
    // STEP 69 - removed line below and replaced by loadcategories()
//    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
    func loadCategories () {
        // STEP 70 - removed do block below and added realm load
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "Message bar", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            // STEP 65 removed line below and added the other one
//            let newCategory = Category(context: self.context)
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            // STEP 72 - Removed as realm are auto updated
//            self.categories.append(newCategory)
            
            // STEP 67 - removed line below and changed func name
//            self.saveCategories()
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (field) in
            textField.placeholder = "Create new category"
            textField = field
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
  
    
    //MARK - Tableview Delegate Methods - STEP 42 - Go the the Items list
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            // STEP 74 - added ? after categories
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
        
    }
    
}
