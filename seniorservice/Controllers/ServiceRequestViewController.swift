//
//  ServiceRequestViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-06-28.
//

import UIKit

class ServiceRequestViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var serviceNameLabel : UILabel!
    @IBOutlet weak var categoryNameLabel : UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var budgetTextField: UITextField!
    
    // Service Name and Category name update dynamically based on the user selection
    var serviceName: String!
    var categoryName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceNameLabel.text = serviceName
        categoryNameLabel.text = categoryName
        descriptionTextView.delegate = self
        budgetTextField.delegate = self
        
        // for tapping
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // Handle tapping to dismiss keyboard
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
        
    
    @IBAction func submitButton(_ sender: Any) {
        var newRequestToBeCreated = Request(category: self.categoryName, service: self.serviceName, budget: 450.0, description: self.descriptionTextView.text, isUrgent: true, createdDate: Date().formatted(), status: "Not Done")
        
        let jsonHelper = JsonHelper()
        guard var requests = jsonHelper.loadRequestsFromFile() else {
            // handle any errors
            return
        }
        requests.append(newRequestToBeCreated)
        
        jsonHelper.saveRequestsToFile(requests: requests)
        
        var isSuccess:Bool
        isSuccess = true
        
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
    }
    
}

extension ServiceRequestViewController /*: UITextFieldDelegate*/ {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



