//
//  ViewController.swift
//  Todoey
//
//  Created by Amie Smith on 4/7/19.
//  Copyright © 2019 Amie Smith. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    // setting up the UITableView controller.  Drag the 'Table View Controller'  then need to change the storyboard entry point to point to the UITableView Controller.   We added a Navigation controller to the Main.Storyboard.  when on the main story board click Editor then click "Embed In" then Navigation controller.   to label the Navigation controller click on the Attributes inspector    <  all of this is found in lec 221 up to 9:46
    
    
    
    //let itemArray = ["Find Mike", "Buy Eggs", "Destory Demogro"]  //added lec 221 9:46 removed lec 223 14:20
    var itemArray = ["Find Mike", "Buy Eggs", "Destory Demogro"] // lec 223 14:20
    
    let defaults = UserDefaults.standard // added lec 225 1:26.  This allows for persisting small bits of local data.
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*lec 225 3:40 the items were saved in the key value par.  to find where the data is persisted locally (stored) we need to get the ID of the app on our hard drive.  and the ID of the sand box.  use the following line of code
         print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)  tthis is place in the appdelegate at the start   note library files are natively hidden on macs to un hide use the terminal functionality and input chflags nohidden ~/Library*/
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] { // added lec 225 9:13
            itemArray = items
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
  
        cell.textLabel?.text = itemArray[indexPath.row] // this is the label that is every cell.  We will set the text property equal to the items in our item array at the indexpath that we ar currently populating
        
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
        
        
        //lec 222 6:40
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            
            
            self.itemArray.append(textField.text!) //force unwraping is by usint the "!".   lec 223 14:40 ideally this item would have checking to make sure the text field had a value and wasn't blank.
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //added 225 2:20
            //self.defaults.set(setValue(self.itemArray, forKey: "TodoListArray"))
            
            self.tableView.reloadData() //lec 223 18:14
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New item"
            textField = alertTextField //added lec 223 ~10- 12 min
            //print(alertTextField.text)// lec 223 7:43  stopped around 8:21 on lec 223
            print("now")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

