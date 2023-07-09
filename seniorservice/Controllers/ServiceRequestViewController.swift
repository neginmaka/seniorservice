//
//  ServiceRequestViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-06-28.
//

import UIKit

class ServiceRequestViewController: UIViewController {
    @IBOutlet weak var serviceNameLabel : UILabel!
    @IBOutlet weak var categoryNameLabel : UILabel!
    
    // Service Name and Category name update dynamically based on the user selection
    var serviceName: String!
    var categoryName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceNameLabel.text = serviceName
        categoryNameLabel.text = categoryName
    }
    
    @IBAction func SubmitButton(_ sender: Any) {
        self.performSegue(withIdentifier: "Submit", sender: self)
    }
}
