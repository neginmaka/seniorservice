//
//  HealthViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-06-30.
//

import UIKit

class HealthViewController: BaseUIViewController {
    
    @IBOutlet weak var nursingButton: UIButton!
    @IBOutlet weak var physioButton: UIButton!
    
    let sequeIdentifier = "ServiceRequest"

    var serviceName : String!
    let caterogryName = "Health"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func NursingButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HealthServicesEnum.Nursing)
    }
    
    @IBAction func PhysioButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HealthServicesEnum.Physiotherapy)
    }
    
    @IBAction func SpeechTherapyoButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HealthServicesEnum.SpeechTherapy)
    }
    
    @IBAction func PersonalCareButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HealthServicesEnum.PersonalCare)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == sequeIdentifier,
            let destinationVC = segue.destination as? ServiceRequestViewController {
            destinationVC.serviceName = serviceName
            destinationVC.categoryName = caterogryName
        }
    }
    
    /// Goes to the Service Request view and set the service name variable
    /// - Parameter service: service name variable selected using the proper enum
    func goToServiceRequestFor(service: HealthServicesEnum) {
        serviceName = service.rawValue
        self.performSegue(withIdentifier: sequeIdentifier, sender: self)
    }
}
