//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: ItemDetailsViewController.swift
//  Description: View controller file for the item details view
//  Last modified on: 4/24/19
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class ItemDetailsViewController: UIViewController {
    //Labels for name and desc, claim ui button, and item image ui image outlets
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var claimBtn: UIButton!
    @IBOutlet weak var itemDesc: UILabel!
    @IBOutlet weak var uploaderEmail: UILabel!
    @IBOutlet weak var returnToWelcomeBtn: UIButton!
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: viewDidLoad ()
    //
    //    Parameters:
    //    none;
    //
    //    Pre-condition: This is a default function in all UIViewController files included by
    //                   Xcode, only has to have the view loaded in.
    //    Post-condition: First will hide both of the buttons on the screen, then we go into the
    //                    database and get data as a dictionary. We change our local labels using
    //                    information from the database. Then it runs the download from URL to UIImageView
    //                    function. Then it prepends a string to the description and email (username).
    //                    Lastly it checks if this is your own item or not and if it has been claimed,
    //                    deciding which button to display.
    //-----------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hiding two buttons at first
        claimBtn.isHidden = true
        returnToWelcomeBtn.isHidden = true
        //Going into database and changing text values on item details screen to database values
        let ref = Database.database().reference()
        ref.child("testItem").observeSingleEvent(of: .value) {
            (snapshot) in
            //Getting data from the database dictionary
            let itemData = snapshot.value as? [String:Any]
            self.itemName.text = itemData!["itemName"] as? String
            self.itemDesc.text = itemData!["itemDescription"] as? String
            self.uploaderEmail.text = itemData!["posterUsername"] as? String
            
            //Download from URL to UIImageView funcition
            self.downloadImageFromURLtoUIImageView(imageURL : (itemData!["imageURL"] as? String)!, localImageView : self.itemImage)

            //Appending text to front of description and email
            self.itemDesc.text = "Description: " + self.itemDesc.text!
            self.uploaderEmail.text = "Uploaded by: " + self.uploaderEmail.text!
            
            //Checking if it's your own item
            let user = Auth.auth().currentUser
            let currentUserEmail = user?.email
            if itemData!["posterEmail"] as! String? == currentUserEmail || itemData!["claimed"] as! Bool? == true{
                //If it is your own item, or it has been claimed then hide the claim button and show return
                self.claimBtn.isHidden = true
                self.returnToWelcomeBtn.isHidden = false
            }
            //Else claim button is not hidden and return is
            else {
                self.claimBtn.isHidden = false;
                self.returnToWelcomeBtn.isHidden = true
            }
        }
    }

    //-----------------------------------------------------------------------------------------
    //
    //  Function: claimActn ()
    //
    //    Parameters:
    //    sender: Any; this is just whatever object that calls this action (put in by Xcode)
    //
    //    Pre-condition: This function just requires that the claim button is clicked.
    //    Post-condition: First we will access the DB and get the current user's email and username.
    //                    Then we will update values in the DB for claimed, claimerEmail, and claimer
    //                    Username. Lastly it will segue to the claim screen.
    //
    //-----------------------------------------------------------------------------------------
    @IBAction func claimActn(_ sender: Any) {
        //Accessing DB
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let currentUserEmail = user?.email
        let currentUsername = user?.displayName
        //Changed claimed status to true and sets claimerEmail
        ref.child("testItem/claimed").setValue(true)
        ref.child("testItem/claimerEmail").setValue(currentUserEmail)
        ref.child("testItem/claimerUsername").setValue(currentUsername)
        //Calls the claimSegue, which segues to the claim view
        self.performSegue(withIdentifier: "claimSegue", sender: self)
    }
}
