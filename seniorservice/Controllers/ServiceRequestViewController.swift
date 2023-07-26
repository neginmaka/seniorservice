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
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentDate)
		self.validateBudgetInput()
        // Initialize newRequestToBeCreated here

//
//        if let budgetText = budgetTextField.text, let budget = Double(budgetText) {
//            newRequestToBeCreated = Request(category: self.categoryName, service: self.serviceName, budget: budget, description: self.descriptionTextView.text, isUrgent: true, createdDate: formattedDate, status: "Not Done")
//        } else {
//            // Set a default budget value if the budgetTextField is empty or invalid
//            newRequestToBeCreated = Request(category: self.categoryName, service: self.serviceName, budget: 0.0, description: self.descriptionTextView.text, isUrgent: true, createdDate: formattedDate, status: "Not Done")
//            budgetTextField.text = "$0.00" // Set the initial text with the $0.00 mask
//        }
        
        // for tapping
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }

	func validateBudgetInput() {
		guard var budgetValue = budgetTextField.text else {
			return
		}
		let valueString = budgetValue.filter {
			CharacterSet(charactersIn: "0123456789.").isSuperset(of: CharacterSet(charactersIn: String($0)))
		}.trimmingCharacters(in: .whitespacesAndNewlines)
		print("---> valueString: \(valueString) ")
		// change the hardcoded dollar sign into the locale currency
		// filter any periods after the first one
		budgetTextField.text = "$ " + valueString
	}

    // Handle tapping to dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate method to handle end of editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == budgetTextField {
            // No need to format the budgetTextField here
            // The budget will be formatted just before submission in the submitButton function
        }
    }
	@IBAction func budgetValueChanged(_ sender: Any) {
		self.validateBudgetInput()
	}
	
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        // Update the isUrgent property of the newRequestToBeCreated object
        newRequestToBeCreated.isUrgent = sender.isOn
    }
    
    
    @IBAction func submitButton(_ sender: Any) {
        
        // Validate the budget input
        if let budgetText = budgetTextField.text, let budget = Double(budgetText) {
            // The budget is a valid Double value
            newRequestToBeCreated.budget = budget
            // Format the budget amount with $0.00 mask and update the budgetTextField text
            let formattedBudget = String(format: "$%.2f", budget)
            budgetTextField.text = formattedBudget
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

// please try to understand before you use it

class CurrencyTextField: UITextField {

	/// The numbers that have been entered in the text field
	private var enteredNumbers = ""

	private var didBackspace = false

	var locale: Locale = .current

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}

	private func commonInit() {
		addTarget(self, action: #selector(editingChanged), for: .editingChanged)
	}

	override func deleteBackward() {
		enteredNumbers = String(enteredNumbers.dropLast())
		text = enteredNumbers.asCurrency(locale: locale)
		// Call super so that the .editingChanged event gets fired, but we need to handle it differently, so we set the `didBackspace` flag first
		didBackspace = true
		super.deleteBackward()
	}

	@objc func editingChanged() {
		defer {
			didBackspace = false
			text = enteredNumbers.asCurrency(locale: locale)
		}

		guard didBackspace == false else { return }

		if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber {
			enteredNumbers.append(lastEnteredCharacter)
		}
	}
}

private extension Formatter {
	static let currency: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		return formatter
	}()
}

private extension String {
	func asCurrency(locale: Locale) -> String? {
		Formatter.currency.locale = locale
		if self.isEmpty {
			return Formatter.currency.string(from: NSNumber(value: 0))
		} else {
			return Formatter.currency.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
		}
	}
}

