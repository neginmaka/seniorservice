//
//  Request Summary.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-07-04.
//

import UIKit

class RequestSummaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func ChooseCatagoryButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Category", sender: self)
    }
}
    
