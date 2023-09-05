//
//  DesignHelper.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-09-04.
//

import Foundation
import UIKit

class DesignHelper {
    
    func generateBackgroundImage(uiView: UIView) {
        // Create a UIImageView
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)

        // Set the image
        backgroundImage.image = UIImage(named: "generic_background.jpg") // Replace with your image's name

        // Make sure the image scales to fill the view
        backgroundImage.contentMode = .scaleAspectFill
        // Add the UIImageView to your view as a subview
        uiView.addSubview(backgroundImage)

        // Send the UIImageView to the back so it doesn't cover other UI elements
        uiView.sendSubviewToBack(backgroundImage)
    }
}
