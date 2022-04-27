//
//  itemViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 26/04/22.
//

import UIKit

class itemViewController: UIViewController {
    
    /*private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "catCell")
        return table
    }()
    
    private let items: [String]
    
    init(Items: [String]) {
        self.items = Items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    public var dataItems:[Category] = [
    ]
    
    var titleTop = ""
    var items: [String]?

    
    @IBOutlet var itemTitleLbl: UILabel!
    @IBOutlet var itemTableView: UITableView!
    
   // buat unwind
    @IBAction func backItemBtn(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToLocation", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTitleLbl.text = titleTop
        itemTableView.delegate = self
        itemTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCat", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(items[indexPath.row])
    }*/

}

extension itemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell")
        cell?.textLabel?.text = dataItems[indexPath.row].locations!
        return cell!
    }
    
    
}
