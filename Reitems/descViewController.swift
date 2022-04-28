//
//  descViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 29/04/22.
//

import UIKit

class descViewController: UIViewController {
    
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var itemPict: UIImageView!
    
    var titleTopDesc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTitle.text = titleTopDesc
        
        print(titleTopDesc)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
