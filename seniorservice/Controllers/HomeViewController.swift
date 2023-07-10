//
//  HomeViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-06-28.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var paintingButton: UIButton!
    @IBOutlet weak var plumbingButton: UIButton!
    
    let sequeIdentifier = "ServiceRequest"

    var serviceName : String!
    let caterogryName = "Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func PaintingButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HomeServicesEnum.Painting)
    }
    
    @IBAction func ElectricalButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HomeServicesEnum.Electrical)
    }
    
    @IBAction func PlumbingButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HomeServicesEnum.Plumbing)
    }
    
    @IBAction func GeneralButton(_ sender: UIButton) {
        goToServiceRequestFor(service: HomeServicesEnum.General)
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
    func goToServiceRequestFor(service: HomeServicesEnum) {
        serviceName = service.rawValue
        self.performSegue(withIdentifier: sequeIdentifier, sender: self)
    }
}
