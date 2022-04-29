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
    var itemIndex = 0
    
    
//    var itemsarrayed: [String]?

    
    @IBOutlet var itemTitleLbl: UILabel!
    @IBOutlet var itemTableView: UITableView!
    
    // Unwinds tanda
    @IBAction func unwindDesc( _ seg: UIStoryboardSegue) {
    }
   
    @IBAction func backItemBtn(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToLocation", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTitleLbl.text = titleTop
        
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
        itemTableView.delegate = self
        itemTableView.dataSource = self

        fetchItems()
    }
    
    
    
//     supaya bisa buka datanya location
    func fetchItems() {
        do {
            let FetchRequest = ItemsClass.fetchRequest()
            let predicate = NSPredicate(format: "itemLocation = %@", currentLocation?.location as! CVarArg)
            FetchRequest.predicate = predicate
            
            self.items = try context.fetch(FetchRequest)

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToDesc", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDesc"{
            let selectedItems = self.currentLocation?.itemArray![itemIndex]
            if let vc = segue.destination as? descViewController {
                vc.titleTopDesc = selectedItems?.itemName ?? "nothing"
            }
        }
    }
        
}
