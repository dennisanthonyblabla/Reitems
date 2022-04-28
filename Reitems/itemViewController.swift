//
//  itemViewController.swift
//  Reitems
//
//  Created by Dennis Anthony on 26/04/22.
//

import UIKit

class itemViewController: UIViewController {
    
    
    var titleTop = ""
    var currentIndex: AllData?
    
    @IBOutlet var itemTitleLbl: UILabel!
    
   
    @IBAction func backItemBtn(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToLocation", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTitleLbl.text = titleTop
        print(currentIndex?.location)
        print(titleTop)

        // Do any additional setup after loading the view.
    }
    
    //unwind function

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
