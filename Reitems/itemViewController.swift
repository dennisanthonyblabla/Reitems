//
//  itemViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 26/04/22.
//

import UIKit

class itemViewController: UIViewController {
    
    
    var titleTop = ""
    var LocationIndexNumber: Int = 0
    var locations: [String]?
    var items: [String]?
    
    @IBOutlet var itemTitleLbl: UILabel!
    @IBOutlet var itemsTable: UITableView!
    
   
    @IBAction func backItemBtn(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToLocation", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTitleLbl.text = titleTop

        // Do any additional setup after loading the view.
    }

}

extension itemViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
