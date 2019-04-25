//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: SignUpViewController.swift
//  Description: View Controller file for the sign up view
//  Last modified on: 4/24/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    //Textfield elements on the screen linked to storyboard
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: signUpActn ()
    //
    //    Parameters:
    //    sender: Any; this is just whatever object that calls this action (put in by Xcode)
    //
    //    Pre-condition: This function just requires that the sign up button is clicked.
    //    Post-condition: It will check if the two password fields match each other and show an
    //                    alert if they don't, it will then check if the username has been filled
    //                    in and alert the user if it hasnt been. If those two prerequisites pass
    //                    then it will create in Firebase and segue to the welcome screen.
    //                    It will also handle any errors that might occur with the fields and give
    //                    an alert.
    //
    // The contents of this function were made with help from the tutorial located here
    // https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-//within-15-mins-df4731faf2f7 Tutorial writer allows others to use functions in their
    // personal apps.
    //-----------------------------------------------------------------------------------------
    @IBAction func signUpActn(_ sender: Any) {
        //Handling if passwords are different, will give alert
        if (passwordField.text != confirmPasswordField.text) {
            self.alertUser(title: "Passwords don't match", message: "Please re-type password")
        }
        else if (usernameField.text == "") {
            self.alertUser(title: "No Username", message: "Please input a username")
        }
        //Else if passwords match and username is present
        else{
            //Create user on firebase
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!){ (user, error) in
                //If no error then segue to the welcome screen
                if error == nil {
                    self.performSegue(withIdentifier: "signUpToWelcome", sender: self)
                }
                //Else handle error and alert user
                else{
                    self.alertUser(title: "Error", message: (error?.localizedDescription)!)
                }
            }
        }
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: prepare()
    //
    //    Parameters:
    //    for segue: UIStoryboardSegue; this tells the prepare function it is preparing for a
    //               UIStoryboardSegue.
    //    sender: Any; this is just whatever object that calls this action (put in by Xcode)
    //
    //    Pre-condition: This function just requires that there is a segue to be preformed.
    //    Post-condition: Makes sure once more than usernameField isn't empty and then it makes
    //                    a WelcomeViewController object so it can access usernameString. It then
    //                    stores the inputted value in usernameField to the username String of
    //                    WelcomeViewController, so it can have that data itself.
    //
    //-----------------------------------------------------------------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if usernameField.text != ""{
            let welcomeViewController = segue.destination as! WelcomeViewController
            welcomeViewController.usernameString = usernameField.text!
        }
    }
    
    //Default function with nothing added, which is automatically put in here by Xcode in all UIViewControllers
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
