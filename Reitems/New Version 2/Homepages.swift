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
    
    
}
