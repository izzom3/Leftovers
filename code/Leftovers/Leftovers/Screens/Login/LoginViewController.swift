//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: LoginViewController.swift
//  Description: View controller file for the login view
//  Last modified on: 4/24/19
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    //Username and password fields on screen
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: loginFunc ()
    //
    //    Parameters:
    //    sender: Any; this is just whatever object that calls this action (put in by Xcode)
    //
    //    Pre-condition: This function just requires that the login button
    //    Post-condition: It will check with Firebase that the email (username) and password match,
    //                    and if they do without error it will segue to the welcome screen. However
    //                    if they don't match (resulting in error) it will alert the user.
    //
    // The contents of this function were made with help from the tutorial located here
    // https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-//within-15-mins-df4731faf2f7 Tutorial writer allows others to use functions in their
    // personal apps.
    //-----------------------------------------------------------------------------------------
    @IBAction func loginFunc(_ sender: Any) {
        //Checking with Firebase if username (email) and password is correct
        Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!) { (user, error) in
            //If no error then segue to welcome screen
            if error == nil{
                self.performSegue(withIdentifier: "loginToWelcome", sender: self)
            }
            //Else if there is an error, alert the user
            else{
                self.alertUser(title: "Error", message: (error?.localizedDescription)!)
            }
        }
    }
    
    //Default function with nothing added, which is automatically put in here by Xcode in all UIViewControllers
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
