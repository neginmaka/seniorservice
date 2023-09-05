//
//  ServiceRequestViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-06-28.
//

import UIKit

class ServiceRequestViewController: BaseUIViewController, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var serviceNameLabel : UILabel!
    @IBOutlet weak var categoryNameLabel : UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet var urgentSwitch: UISwitch!

    let local : Locale = .current
    
    // Service Name and Category name update dynamically based on the user selection
    var serviceName: String!
    var categoryName: String!
    
    // Initialize newRequestToBeCreated here
    var newRequestToBeCreated = Request(
        category: "",
        service: "",
        budget: 0,
        description: "",
        isUrgent: false,
        createdDate: "",
        status: ServiceStatusEnum.New.rawValue
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceNameLabel.text = serviceName
        categoryNameLabel.text = categoryName
        descriptionTextView.delegate = self
        budgetTextField.delegate = self
        budgetTextField.placeholder = local.currencySymbol!
        
		// Guarding the bugdet input field against non digits chars
        self.guardBudgetInputForNonDigits()
        
        // for tapping
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }

	func guardBudgetInputForNonDigits() {
		guard let budgetValue = budgetTextField.text else {
			return
		}
		let valueString = budgetValue.filter {
			CharacterSet(charactersIn: "0123456789.").isSuperset(of: CharacterSet(charactersIn: String($0)))
		}.trimmingCharacters(in: .whitespacesAndNewlines)

        budgetTextField.text = valueString
	}

    // Handle tapping to dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate method to handle end of editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == budgetTextField {
        }
    }
    
	@IBAction func budgetValueChanged(_ sender: Any) {
		self.guardBudgetInputForNonDigits()
	}
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        // Update the isUrgent property of the newRequestToBeCreated object
        newRequestToBeCreated.isUrgent = sender.isOn
    }
    
    @IBAction func submitButton(_ sender: Any) {
        // Validate the budget input
        if let budgetText = budgetTextField.text, let budget = Double(budgetText) {
            newRequestToBeCreated.budget = budget
            let formattedBudget = String(format: "%.2f", budget)
            budgetTextField.text = formattedBudget
        } else {
            // Show an alert to the user that the budget input is invalid
            let alertController = UIAlertController(title: "Invalid Budget", message: "Please enter a valid number for the budget.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return // Stop the submission process if the budget is invalid
        }
        
        newRequestToBeCreated.isUrgent = urgentSwitch.isOn
        newRequestToBeCreated.description = descriptionTextView.text
        newRequestToBeCreated.service = serviceName
        newRequestToBeCreated.category = categoryName
        newRequestToBeCreated.createdDate = getCurrentFormattedDate()
        
        writeToDB(newRequestToBeCreated: newRequestToBeCreated)
        
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

private func getCurrentFormattedDate() -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let formattedDate = dateFormatter.string(from: currentDate)
    return formattedDate
}

private func writeToDB(newRequestToBeCreated: Request) {
    // TODO: Replace with real DB connections
    let jsonHelper = JsonHelper()
    guard var requests = jsonHelper.loadRequestsFromFile() else {
        // handle any errors
        return
    }
    requests.append(newRequestToBeCreated)
    jsonHelper.saveRequestsToFile(requests: requests)
}
