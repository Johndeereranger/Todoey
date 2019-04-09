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
    
    
    
    let itemArray = ["Find Mike", "Buy Eggs", "Destory Demogro"]  //added lec 221 9:46
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark //removed 222 6:40 */
        
        
        //lec 222 6:40
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    
    // MARK - Source Control
    //lec 223 
    
}

