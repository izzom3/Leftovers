//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: ClaimViewController.swift
//  Description: View Controller file for the claim view
//  Last modified on: 4/24/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ClaimViewController: UIViewController {
    //Label and image for item on the screen, linked to storyboard
    @IBOutlet weak var claimItemName: UILabel!
    @IBOutlet weak var claimItemImage: UIImageView!
    @IBOutlet weak var messageUserBtn: UIButton!
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: messageUserActn()
    //
    //    Parameters:
    //    sender: UIButton; this is the object (a button) that calls this function
    //
    //    Pre-condition: This function just requires that the message user button was clicked.
    //    Post-condition: This function will send the user an alert about messaging, and it will
    //                    then return them to the intiial screen.
    //
    //-----------------------------------------------------------------------------------------
    @IBAction func messageUserActn(_ sender: Any) {
        //Alert user
        alertUser(title: "Coming Soon!", message: "Messaging will be available soon.")
        
        //Going back to initial storyboard screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: viewDidLoad ()
    //
    //    Parameters:
    //    none;
    //
    //    Pre-condition: This is a default function in all UIViewController files included by
    //                   Xcode, only has to have the view loaded in.
    //    Post-condition: First this will hide the back button. Then it referencing the database
    //                    and gets data from it through a dictionary. It then calls the download
    //                    image from url function so we have the item image. Then it updates the
    //                    item name label and message button label from the database and prepends
    //                    messages onto both.
    //-----------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hiding back button in top navbar
        self.navigationItem.setHidesBackButton(true, animated:true);
        //Referencing database
        let ref = Database.database().reference()
        ref.child("testItem").observeSingleEvent(of: .value) {
            (snapshot) in
            //Getting data from the database dictionary
            let itemData = snapshot.value as? [String:Any]
            //Download and change the imageView to image from DB
            self.downloadImageFromURLtoUIImageView(imageURL: (itemData!["imageURL"] as? String)!, localImageView: self.claimItemImage)
                //Changing item name and prepending
                self.claimItemName.text = itemData!["itemName"] as? String
            self.claimItemName.text = "Congrats, you have claimed " + self.claimItemName.text! + "!"
                //Changing button title and prepending
                self.messageUserBtn.setTitle(itemData!["posterUsername"] as? String, for: .normal)
                self.messageUserBtn.setTitle("Message: " + self.messageUserBtn.title(for: .normal)!, for: .normal)
        }
    }
}
