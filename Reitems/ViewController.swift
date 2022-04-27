//
//  ViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 25/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    struct category {
        let location: String
        let items: [String]
    }

    var arrLocation = ["Bedroom Box Storage", "Bedroom Blue Case", "Living Room Key Storage", "Living Room Book Shelve", "Toilet Medicine Box"]
    var index = 0
    
    
    @IBOutlet var catTableView: UITableView!
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        // Create Alert
        let alert = UIAlertController(title: "Add Location", message: "What location would you add?", preferredStyle: .alert)
        alert.addTextField()
        // Configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            // Get the textField for the alert
            let textField = alert.textFields![0]
            // Create a person object
            let newLocation = textField.text!
            // Save the data
            self.arrLocation.append(newLocation)
            self.catTableView.reloadData()
        }
        // Add button
        alert.addAction(submitButton)
        // Show alert
        self.present(alert, animated: true)
    }
    
    private let data:[category] = [
        category(location: "Bedroom Box Storage", items: ["gamepad", "comb"] ),
        category(location: "Bedroom Blue Case", items: ["watch", "wipes", "Spare Mouse"]),
        category(location: "Living Room Key Storage", items: ["Front Door Key", "Master Bedroom Key"]),
        category(location: "Living Room Book Shelve", items: ["Dummies for Windows", "Hacking With Swift", "English Proficiency"]),
        category(location: "Toilet Medicine Box", items: ["Blue Pill", "Red Pill", "Pill Chi Kit", "Coughing Drops", "Shave Foam"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem


        catTableView.register(UITableViewCell.self, forCellReuseIdentifier: "catCell")
        catTableView.delegate = self
        catTableView.dataSource = self
        catTableView.dragDelegate = self
        catTableView.dragInteractionEnabled = true
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "catCell")
            
            cell?.textLabel?.text = arrLocation[indexPath.row]
            
            return cell!
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrLocation.count
        }
        
    /*    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                print("DELETED \(indexPath.row)")
                arrFruits.remove(at: indexPath.row)
                tableView.reloadData()
            }
        } */

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
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
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let VC = itemViewController()
//        VC.itemTitleLbl.text = arrLocation[index]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var destination = segue.destination as! itemViewController
//        destination.itemTitleLbl.text = arrLocation[index]
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToItems") {
            let vc = segue.destination as! itemViewController
            vc.itemTitleLbl.text = "test"
        }
    }*/
        
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
