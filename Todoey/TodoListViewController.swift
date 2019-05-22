//
//  ViewController.swift
//  Todoey // currently through lec 228
//
//  Created by Amie Smith on 4/7/19.
//  Copyright © 2019 Amie Smith. All rights reserved.
//

import UIKit
import CoreData // lec 237

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()  // this changes from an array of strings to an array of item objects.
    
    //let defaults = UserDefaults.standard // added lec 225 1:26.  This allows for persisting small bits of local data. removed 233 5:02
    
            let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // lec 237
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
        
        
        /* commented out on lec 229 7:36 and replaced by lines above
         if let items = defaults.array(forKey: "TodoListArray") as? [String] { // added lec 225 9:13
         itemArray = items */
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        
    }
    //MARK - Tableview Datasource Methods
    
    //lec 221 10:56
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count // returns the number of rows in the array.
    }
    
    //asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //lec 221 13:38
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
  
        
        // Section B a shorter method  Lec 229 17:00 & lec 230 (all)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        /*//Ternary Operator ==>
        //Value = condition ? valueIfTrue : valueIfFalse
        // long method
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.accessoryType = item.done == true ? .checkmark : .none  // can be made shorter by using the code below
        cell.accessoryType = item.done ? .checkmark : .none */
        
        /* Section B - this is a longer version of completing section B
        cell.textLabel?.text = itemArray[indexPath.row].title // this is the label that is every cell.  We will set the text property equal to the items in our item array at the indexpath that we ar currently populating  added the .title in lec 229 9:21
        
        // added lec 229 11:53   this is replaces Section A below and is simplifed above in ternary operator
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        } */
        
        return cell
    }

    //MARK - TableView Delegate Methods
    
    //lec 241
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row) // this will print out what row of the index path is selected
        print(itemArray[indexPath.row]) // this will print out what is actually the row described is selected.
        
        /*
        //lec 242
        context.delete(itemArray[indexPath.row])  // must be called first the order of operations matters
        itemArray.remove(at: indexPath.row)
        */
        
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
         tableView.deselectRow(at: indexPath, animated: true)
    }
        
    // MARK - Source Control
    //lec 223 to make a github you click source control >Committ.  to view all stored items click on the source control and click on branches.
    
    // MARK - Add New items
    //lec 223 3:17
    
        

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()  // this variable is a local variable that is only available to all of the code inside of this function
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)// lec 223 4:17
        
         let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //lec 237 ~2:00
            //let context =(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newItem = Item(context: self.context)
            

            print("Add item Pressed!")
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New item"
             textField = alertTextField //added lec 223 ~10- 12 min
            //print(alertTextield.text)// lec 223 7:43  stopped around 8:21 on lec 223
            print("now") }
    
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    
    }
    func saveItems() {// lec 237 4:30
       
        do{
           try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
//    func loadItems() {  //lec 240 1:01  created new in lec 243
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        do{
//        itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    //lec 243 19:45
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
      
        do{
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}

// MARK: - Search Bar Methods

// lec 243 6:00
extension TodoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //lec 243 10:43 shorted at 19:45
        /*let predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        request.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do{itemArray = try context.fetch(request) } catch {
            print("Error fetching data from context \(error)")}
        tableView.reloadData() */
        
        //shortened starting lec 243 19:45
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
       
        loadItems(with: request)
    }
    
    //lec 243
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            //lec 243 3:09
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
    
        
    }
    

