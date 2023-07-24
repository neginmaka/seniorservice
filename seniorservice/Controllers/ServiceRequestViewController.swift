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
        
        //        descriptionTextView.delegate = self
        //        budgetField.delegate = self
    }
    
    @IBAction func submitButton(_ sender: Any) {
		var newRequestToBeCreated = Request(category: self.categoryName, service: self.serviceName, budget: 450.0, description: "Anything just to test", isUrgent: true, createdDate: Date().formatted(), status: "Not Done")

		let jsonHelper = JsonHelper()
		guard var requests = jsonHelper.loadRequestsFromFile() else {
			// handle any errors
			return
		}
		requests.append(newRequestToBeCreated)

		jsonHelper.saveRequestsToFile(requests: requests)

        var isSuccess:Bool
        isSuccess = true
        
        // TODO: Create a Request object based on user input
        
        //        var request = Request()
        //            request.description = descriptionTextField.text
        //            request.createdDate = Date()
        //            request.status = .created
        
        
        
        // TODO: (Temporary until DB is created) Load all requests and serialize them to an array of Requests
        
        // TODO: Append the new Request object to the list of Requests
        
        // TODO: Push the new Request list to DB aka the jsonFile
        
        // TODO: Create a status check for the push:
        
        if(isSuccess) {
            let alertController = UIAlertController(title: "Request Sent", message: "Your request was successfully sent", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Go back to home", style: .default, handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Request Sent", message: "There was an error with the request. Try again later", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Go back to request screen", style: .default, handler: { _ in
            }))
            present(alertController, animated: true, completion: nil)
        }
    }}
