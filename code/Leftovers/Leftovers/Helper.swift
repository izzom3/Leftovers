//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: Helper.swift
//  Description: Contains modularized functions used multiple times throughout the project
//  Last modified on: 4/24/19
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    //-----------------------------------------------------------------------------------------
    //
    //  Function: alertUser ()
    //
    //    Parameters:
    //    title: String; Title of the alert message
    //    message: String; Message of the alert message
    //
    //    Pre-condition: Function is called and valid title and message are included.
    //    Post-condition: First it will build the alert with the title and message and make OK as
    //                    defaultAction. Then it will add that action to the popup and send it to
    //                    the user's screen.
    //
    //-----------------------------------------------------------------------------------------
    func alertUser (title: String, message: String) {
        //Build alert
        let alertPopup = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //Add action to popup and send
        alertPopup.addAction(defaultAction)
        self.present(alertPopup, animated: true, completion: nil)
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: downloadImageFromURLtoUIImageView()
    //
    //    Parameters:
    //    imageURL: String; URL of the image
    //    localImageView: UIImageView; UIImageView that picture will be downloaded to.
    //
    //    Pre-condition: Image URL gotten from DB, valid UIImage and valid parameter inputs into
    //                   this function.
    //    Post-condition: First it does the actual downloading use the URL and then it stores that
    //                    image data to the specified UIImage.
    //
    //-----------------------------------------------------------------------------------------
    func downloadImageFromURLtoUIImageView(imageURL : String, localImageView : UIImageView) {
        //Download image from URL
        let url = URL(string: imageURL)
        let data = try? Data(contentsOf: url!)
        //Store to itemImage
        if let imageData = data {
            localImageView.image = UIImage(data: imageData)
        }
    }
}
