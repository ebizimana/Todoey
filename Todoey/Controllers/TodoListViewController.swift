//
//  ViewController.swift
//  Todoey
//
//  Created by Elie Bizimana on 4/26/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // load items that just been added
        
        let newItem = Item()
        newItem.title = "Find Milk"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Now What"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Please tell me it works"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }
    
    // MARK - Tableview Datasource Methods
    
    // Number of rows needed
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Add an item in the array in each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Tenary operator explained
        /*********************************** |
        | Ternary Operator ==>                                       |
        | value = condition ? valueIfTrue : valueIfFalase |
        |*************************************|
        */
        
        // Tenary operator Put in Action
        cell.accessoryType = item.done == true ? .checkmark: .none
        
        // it can also be expresses as
        // cell.accessoryType = item.done ? .checkmark: .none

        return cell
    }
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Toggles the done property in the item Class from False and True
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // Reloads the table view
        tableView.reloadData()
        // deselect after clicking on a row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // it holds the value inserted in the textfield
        var textField = UITextField()
        
        // create an alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        // Add an action on the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the add item button on our UIAlert
            // Append the new item in the array
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            // item added to persist after closure of the app
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            // Reloads the rows of the table view
            self.tableView.reloadData() 
        }
        // Create a text field in the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            // send the inserted data to the textfield var
            textField = alertTextField
        }
        // Connect the alert controller to alert action
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    


}

