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
    
    //var description: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceNameLabel.text = serviceName
        categoryNameLabel.text = categoryName
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        // TODO: Create a Request object based on user input
        
//        var request = Request()
//            request.description = descriptionTextField.text
//            request.createdDate = Date()
//            request.status = .created
        }
        
        // TODO: (Temporary until DB is created) Load all requests and serialize them to an array of Requests
        
        // TODO: Append the new Request object to the list of Requests
        
        // TODO: Push the new Request list to DB aka the jsonFile
        
        // TODO: Create a status check for the push:
        // TODO: if all successful: show success pop up and navigate to root
        // Show popup
        let alertController = UIAlertController(title: "Request Sent", message: "Your request was successfully sent", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Go back to home", style: .default, handler: { _ in
            // Navigate to root view
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alertController, animated: true, completion: nil)
        
        // TODO: if failed: show failed pop up and navigate to the same view
    
    }
