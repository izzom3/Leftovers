//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: InitialViewController.swift
//  Description: View Controller file for the initial view
//  Last modified on: 4/24/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialViewController: UIViewController {
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: viewDidAppear ()
    //
    //    Parameters:
    //    animated bool; Is it animated, true or false
    //
    //    Pre-condition: this is an overriden function that is included in the UIViewController
    //                   class from Xcode, no precondictions
    //    Post-condition: Whenever this view appears, the Auth from Firebase will check if a
    //                    a user is currently signed, and segue to the welcome screen if yes.
    //-----------------------------------------------------------------------------------------
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        //Checking if user is signed in our not
        if Auth.auth().currentUser != nil {
            //Segue to welcome screen if yes
            self.performSegue(withIdentifier: "initialToWelcome", sender: nil)
        }
    }
    
    //Default function with nothing added, which is automatically put in here by Xcode in all UIViewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
