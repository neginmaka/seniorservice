//
//  BaseUIViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-09-04.
//

import Foundation
import UIKit

class BaseUIViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DesignHelper().generateBackgroundImage(uiView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DesignHelper().generateBackgroundImage(uiView: self.view)
    }
}
