//
//  ViewController.swift
//  Todoey
//
//  Created by Elie Bizimana on 4/26/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Add a checkmark when you select a row
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            self.itemArray.append(textField.text!)
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

