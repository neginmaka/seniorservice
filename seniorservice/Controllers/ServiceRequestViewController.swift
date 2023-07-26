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
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet var urgentSwitch: UISwitch!
    
    // Service Name and Category name update dynamically based on the user selection
    var serviceName: String!
    var categoryName: String!
    var newRequestToBeCreated: Request!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceNameLabel.text = serviceName
        categoryNameLabel.text = categoryName
        descriptionTextView.delegate = self
        budgetTextField.delegate = self
        
        // Initialize newRequestToBeCreated here
        newRequestToBeCreated = Request(category: self.categoryName, service: self.serviceName, budget: 450.0, description: self.descriptionTextView.text, isUrgent: true, createdDate: Date().formatted(), status: "Not Done")
        
        // for tapping
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // Handle tapping to dismiss keyboard
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    @IBAction func switchDidChange(_ sender: UISwitch) {
        // Update the isUrgent property of the newRequestToBeCreated object
            newRequestToBeCreated.isUrgent = sender.isOn
        }
        
    
    @IBAction func submitButton(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
        // Validate the budget input
                if let budgetText = budgetTextField.text, let budget = Double(budgetText) {
                    // The budget is a valid Double value
                    newRequestToBeCreated.budget = budget
                } else {
                    // Show an alert to the user that the budget input is invalid
                    let alertController = UIAlertController(title: "Invalid Budget", message: "Please enter a valid number for the budget.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                    return // Stop the submission process if the budget is invalid
                }
                
                // Update the isUrgent property based on the switch value (redundant since it's already updated in switchDidChange)
                newRequestToBeCreated.isUrgent = urgentSwitch.isOn
                
                let jsonHelper = JsonHelper()
                guard var requests = jsonHelper.loadRequestsFromFile() else {
                    // handle any errors
                    return
                }
                requests.append(newRequestToBeCreated)
                
                jsonHelper.saveRequestsToFile(requests: requests)
                
                // Since we don't have a real server response, we can assume the request was successful
                let alertController = UIAlertController(title: "Request Sent", message: "Your request was successfully sent", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Go back to home", style: .default, handler: { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                present(alertController, animated: true, completion: nil)
            }
        }

extension ServiceRequestViewController /*: UITextFieldDelegate*/ {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



