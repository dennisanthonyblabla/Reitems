//
//  ViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 25/04/22.
//

import UIKit

class ViewController: UIViewController {
    

    var arrLocation = ["Bedroom Box Storage", "Bedroom Blue Case", "Living Room Key Storage", "Living Room Book Shelve", "Toilet Medicine Box"]
    var index = 0
    
    private let data:[Category] = [
        Category(locations: "bedroom", items: ["psp","Playstation 2"]),
        Category(locations: "living Room", items: ["comb", "hair dryer"]),
        Category(locations: "Bathroom", items: ["faucet", "water sprayer"])
//        Category(location: [LocationDetail(detailName: "Bedroom Box Storage", detailAttribuite: DetailAtributeModel(location: <#T##String?#>, desc: <#T##String?#>, date: <#T##String?#>))])
//        category(location: "Bedroom Box Storage", items: ["gamepad", "comb"] ),
//        category(location: "Bedroom Blue Case", items: ["watch", "wipes", "Spare Mouse"]),
//        category(location: "Living Room Key Storage", items: ["Front Door Key", "Master Bedroom Key"]),
//        category(location: "Living Room Book Shelve", items: ["Dummies for Windows", "Hacking With Swift", "English Proficiency"]),
//        category(location: "Toilet Medicine Box", items: ["Blue Pill", "Red Pill", "Pill Chi Kit", "Coughing Drops", "Shave Foam"])
    ]
    
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "catCell")
            cell?.textLabel?.text = data[indexPath.row].locations
            return cell!
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let vc = segue.destination as? itemViewController {
                vc.titleTop = data[index].locations!
                vc.dataItems = data
                
            }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let action = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
                self.arrLocation.remove(at: indexPath.row)
                tableView.reloadData()
                print("Button Clicked")
            }
            action.backgroundColor = UIColor.red
        return [action]
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
