//
//  Homepages.swift
//  Reitems
//
//  Created by Dennis Anthony on 19/06/22.
//

import UIKit

class Homepages: UIViewController {
    
    @IBOutlet weak var ItemTableView: UITableView!
    @IBOutlet weak var ItemsAddBtn: UIBarButtonItem!
    
    struct Items {
        var Item: String
    }
    
    var FirstItems = [Items(Item: "Tables"), Items(Item: "Chair"), Items(Item: "Mug")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ItemTableView.delegate = self
        ItemTableView.dataSource = self
    }
    
    
    @IBAction func AddItems(_ sender: UIBarButtonItem) {
        
    }
    
}

extension Homepages: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FirstItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCellsID", for: indexPath)
        cell.textLabel?.text = FirstItems[indexPath.row].Item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create swipe action
        let locationDelete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.FirstItems.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
        
        let locationEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            // Which person to remove
            let locationToEdit = self.FirstItems[indexPath.row]
            // Edit alert
            let alert = UIAlertController(title: "Edit Location", message: "Rename the location", preferredStyle: .alert)
            alert.addTextField()
            
            let textField = alert.textFields![0]
            textField.text = locationToEdit.Item
            
            // Configure button handler
            let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
                // Get the textfield for the alert
                let locationInput = alert.textFields![0]
                // Edit name property of person object
                self.FirstItems[indexPath.row].Item = locationInput.text ?? "Fail"
                tableView.reloadData()
            }
            alert.addAction(saveButton)
            self.present(alert, animated: true)
        }
    
        return UISwipeActionsConfiguration(actions: [locationDelete, locationEdit])
    }
}

extension Homepages: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = FirstItems[indexPath.row]
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mv = FirstItems[sourceIndexPath.row]
        FirstItems.remove(at: sourceIndexPath.row)
        FirstItems.insert(mv, at: destinationIndexPath.row)
        
        
        
    }
}
