//
//  ViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-06-26.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var healthButton: UIButton!
    @IBOutlet weak var PreviousRequestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "HomeServiceController") as! HomeViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func healthButton(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "HealthServiceController") as! HealthViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func PreviousRequestButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PreviousRequest", sender: self)
    }
}
