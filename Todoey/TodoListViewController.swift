//
//  ViewController.swift
//  Todoey // currently through lec 228
//
//  Created by Amie Smith on 4/7/19.
//  Copyright © 2019 Amie Smith. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    // setting up the UITableView controller.  Drag the 'Table View Controller'  then need to change the storyboard entry point to point to the UITableView Controller.   We added a Navigation controller to the Main.Storyboard.  when on the main story board click Editor then click "Embed In" then Navigation controller.   to label the Navigation controller click on the Attributes inspector    <  all of this is found in lec 221 up to 9:46
    
    //let itemArray = ["Find Mike", "Buy Eggs", "Destory Demogro"]  //added lec 221 9:46 removed lec 223 14:20
    //var itemArray = ["Find Mike", "Buy Eggs", "Destory Demogro"] // lec 223 14:20   removed lec 229 7:47
    var itemArray = [Item]()  // this changes from an array of strings to an array of item objects.
    
    //let defaults = UserDefaults.standard // added lec 225 1:26.  This allows for persisting small bits of local data. removed 233 5:02
    
            let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*lec 225 3:40 the items were saved in the key value par.  to find where the data is persisted locally (stored) we need to get the ID of the app on our hard drive.  and the ID of the sand box.  use the following line of code
         print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)  tthis is place in the appdelegate at the start   note library files are natively hidden on macs to un hide use the terminal functionality and input chflags nohidden ~/Library*/
        
        /*lec 233 1:34  hint in the section for document directory just place a . in the area and then a list of potential options will show up.  Moved to class sectin at lec 233 7:12
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        print (dataFilePath)  */
        
        /*added lec 229 8:35  this was laid out in detail in the quizzler app.  removed 234 3:45
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy eggse"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "find me"
        itemArray.append(newItem3)  */

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
    
    //lec 222 1:07
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row) // this will print out what row of the index path is selected
        print(itemArray[indexPath.row]) // this will print out what is actually the row described is selected.
        //lec 222 2:49 for the above lines
        
        //lec 222 3:05 - this make the table viewthat is selected no longer highlighted when it is selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        /*lec 222 4:30 - on the main.storyboard.  on the attribute inspector there is an accessory function this will be adjusting that.  this will add the checkmark but will not remove it
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark //removed 222 6:40   */
        
        
        /*lec 229 10:19  below is the long way of writing this out
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false }  removed on lec 229 15:55 and replaced by
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done */
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
       // tableView.reloadData() //lec 229 13:15  this forces the table view to reload the data.  removed lec 233 12:21 with addition of saveItems fucntion no longer needed
        
        
        /*added lec 222 6:40   removed lec 229 11:53  SECTION A
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
     */
    }
        
    // MARK - Source Control
    //lec 223 to make a github you click source control >Committ.  to view all stored items click on the source control and click on branches.
    
    // MARK - Add New items
    //lec 223 3:17
    
        

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()  // this variable is a local variable that is only available to all of the code inside of this function
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)// lec 223 4:17
        
         let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Code what will happen once the user clicks the add item button on our UIAlert
            print("Add item Pressed!")
                    print(textField.text)  // if not understood review lessons of scope covered earlier on
            let newItem = Item() // created lec 229 9:34
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
        }
            //self.itemArray.append(textField.text!) //force unwraping is by usint the "!".   lec 223 14:40 ideally this item would have checking to make sure the text field had a value and wasn't blank.
            //self.defaults.set(self.itemArray, forKey: "TodoListArray") //added 225 2:20  removed lec 233 5:04 replaced by Section C
            //self.defaults.set(setValue(self.itemArray, forKey: "TodoListArray"))
            
            /*section C added lec 233 5:04  removed lec 233 11:57 created function saveItems below
            let encoder = PropertyListEncoder()
            do{
            let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            } catch {
                print("Error encodeing item array, \(error)")}
            
            self.tableView.reloadData() //lec 223 18:14
        } */
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New item"
             textField = alertTextField //added lec 223 ~10- 12 min
            //print(alertTextield.text)// lec 223 7:43  stopped around 8:21 on lec 223
            print("now") }
    
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    
    }
    func saveItems() {  // lec 233 11:57
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encodeing item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {  //lec 234 1:55
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding item array, \(error)")
        }
    }
}
}

