//
//  itemViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 26/04/22.
//

import UIKit

class itemViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentLocation: LocationsClass?
    var titleTop = ""
    var items: [ItemsClass]?
//    var itemsarrayed: [String]?

    
    @IBOutlet var itemTitleLbl: UILabel!
    @IBOutlet var itemTableView: UITableView!
    
   
    @IBAction func backItemBtn(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToLocation", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTitleLbl.text = titleTop
        print(currentLocation)
        print(titleTop)
        
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
        itemTableView.delegate = self
        itemTableView.dataSource = self

        fetchItems()
    }
    
    
//     supaya bisa buka datanya location
    func fetchItems() {
        do {
            self.items = try context.fetch(ItemsClass.fetchRequest())

            DispatchQueue.main.async {
                self.itemTableView.reloadData()
            }
        } catch {
            print(error)
        }
    }

}

extension itemViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentLocation?.itemArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        
        cell.textLabel?.text = currentLocation?.itemArray?[indexPath.row].itemName

        
        return cell
    }
    
}
