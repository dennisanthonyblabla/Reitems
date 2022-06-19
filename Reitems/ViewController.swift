//
//  ViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 25/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var locations: [LocationsClass]?

    var arrLocation = ["Bedroom Box Storage", "Bedroom Blue Case", "Living Room Key Storage", "Living Room Book Shelve", "Toilet Medicine Box"]
    var index = 0
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    @IBOutlet var titleLocationLabel: UILabel!
    @IBOutlet var catTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //font setting
//        let boldAttribute = [
//              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
//           ]
//        let boldText = NSAttributedString(string: "test", attributes: boldAttribute)
//        let newString = NSMutableAttributedString()
//        newString.append(boldText)
//        titleLocationLabel.attributedText = newString
        
        

        catTableView.register(UITableViewCell.self, forCellReuseIdentifier: "catCell")
        catTableView.delegate = self
        catTableView.dataSource = self
        catTableView.dragDelegate = self
        catTableView.dragInteractionEnabled = true
        
        fetchLocation()
    }
    
    // supaya bisa buka datanya location
    func fetchLocation() {
        do {
            self.locations = try context.fetch(LocationsClass.fetchRequest())
            
            DispatchQueue.main.async {
                self.catTableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        // Create Alert
        let alert = UIAlertController(title: "Add Location", message: "What location would you add?", preferredStyle: .alert)
        alert.addTextField()
        // Configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            // Get the textField for the alert
            let textField = alert.textFields![0]
            // Create new location
            let newLocation = LocationsClass(context: self.context)
            newLocation.location = textField.text
            
            // add new items in location
            let newItems = ItemsClass(context: self.context)
            newItems.itemName = "oke"
            newItems.itemID  = 1
            newItems.itemDesc = "Ini deskripsinya"
        
            let newItems2 = ItemsClass(context: self.context)
            newItems2.itemName = "mantap"
            newItems2.itemID = 2
            newItems2.itemDesc = "Ini deskripsinya 2"
            
            let newItems3 = ItemsClass(context: self.context)
            newItems3.itemName = "siap"
            newItems3.itemID = 3
            newItems3.itemDesc = "Ini deskripsinya 3"
            
            newLocation.itemsRelation = NSSet.init(array: [newItems, newItems2, newItems3])
//            newItems.location = newLocation
            
            // Save the data
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            // Re-fetch the data
            self.fetchLocation()
        }
        // Add button
        alert.addAction(submitButton)
        // Show alert
        self.present(alert, animated: true)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath)
            
            let locationArr = self.locations![indexPath.row]
        
            cell.textLabel?.text = locationArr.location
            
            return cell
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems"{
        let selectecLocation = self.locations![index]
            if let vc = segue.destination as? itemViewController {
                vc.titleTop = selectecLocation.location ?? "nothing"
                vc.currentLocation = selectecLocation
            }}
    }

    /*func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let action = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
                self.arrLocation.remove(at: indexPath.row)
                tableView.reloadData()
                print("Button Clicked")
            }
            
            /*let action2 = UITableViewRowAction(style: .normal, title: "wow") { (action, indexPath) in
                print("Button Clicked")
            }*/
            
            action.backgroundColor = UIColor.red
            //action2.backgroundColor = UIColor(red: 0.02, green: 0.60, blue: 0.56, alpha: 1.00)
        return [action]
        }*/
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Which person to remove
            let locationToRemove = self.locations![indexPath.row]
            // Remove the person
            self.context.delete(locationToRemove)
            // Save the data
            do {
                try self.context.save()
            } catch {
                
            }
            // Re-fetch the data
            self.fetchLocation()
        }
        
        let action2 = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            // Which person to remove
            let locationToEdit = self.locations![indexPath.row]
            // Edit alert
            let alert = UIAlertController(title: "Edit Location", message: "Rename the location", preferredStyle: .alert)
            alert.addTextField()
            
            let textField = alert.textFields![0]
            textField.text = locationToEdit.location
            
            // Configure button handler
            let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
                
                // Get the textfield for the alert
                let textField = alert.textFields![0]
                
                // Edit name property of person object
                locationToEdit.location = textField.text
                
            
            // Save the data
            do {
                try self.context.save()
            } catch {
            }
            // Re-fetch the data
            self.fetchLocation()
            }
            alert.addAction(saveButton)
            // Show alert
            self.present(alert, animated: true)
        }
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action, action2])
    }

        
}

extension ViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = arrLocation[indexPath.row]
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mv = arrLocation[sourceIndexPath.row]
        arrLocation.remove(at: sourceIndexPath.row)
        arrLocation.insert(mv, at: destinationIndexPath.row)
        
        
        
    }
}
