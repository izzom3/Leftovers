//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: WelcomeViewController.swift
//  Description: View Controller file for the welcome view
//  Last modified on: 4/24/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class WelcomeViewController: UIViewController {
    //Getting current user for use throughout class
    let user = Auth.auth().currentUser
    
    //Username label from screen
    @IBOutlet weak var usernameLbl: UILabel!
    
    //String used to change username label
    var usernameString = String()
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: logoutFunc()
    //
    //    Parameters:
    //    sender: UIButton; The object (UIButton) that will call the function
    //
    //    Pre-condition: This function just requires that the log out button was clicked.
    //    Post-condition: First the function will attempt to logout using a Firebase signOut function.
    //                    If it fails it will catch the error and alert the user. Then it will
    //                    return the user to the initial storyboard screen.
    //
    // The contents of this function were made with help from the tutorial located here
    // https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-//within-15-mins-df4731faf2f7 Tutorial writer allows others to use functions in their
    // personal apps.
    //-----------------------------------------------------------------------------------------
    @IBAction func logoutFunc(_ sender: UIButton) {
        //Trying to logout
        do {
            try Auth.auth().signOut()
        }
        //Catching any error and alerting user
        catch let logOutError as NSError {
            print ("Error signing out: %@", logOutError)
            self.alertUser(title: "Logout Error", message: "Please try again.")
        }
        
        //Going back to initial storyboard screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: myPostsActn()
    //
    //    Parameters:
    //    sender: UIButton; The object (UIButton) that will call the function
    //
    //    Pre-condition: This function just requires that the My Posts button was clicked.
    //    Post-condition: First this function will get the current user's email and reference the
    //                    the database. It will compare the posterEmail in their to the current
    //                    email. It will proceed else it will alert the user that they have no
    //                    posts. Then it will check if the item is claimed, if it isn't then it
    //                    will display that post to the user, else it will tell the user who has
    //                    claimed their post.
    //
    //-----------------------------------------------------------------------------------------
    @IBAction func myPostsActn(_ sender: UIButton) {
        //Get current user's email and reference the database
        let currentUserEmail = user?.email
        let ref = Database.database().reference()
        ref.child("testItem").observeSingleEvent(of: .value) {
            (snapshot) in
                let itemData = snapshot.value as? [String:Any]
            //If current user has a post proceed
            if (itemData!["posterEmail"] as! String? == currentUserEmail) {
                //If that post also isn't claimed then go to that post
                if (itemData!["claimed"] as! Bool? == false) {
                    self.performSegue(withIdentifier: "myPostsSegue", sender: self)
                }
                //If that post is claimed then alert the user
                else {
                    self.alertUser(title: "Post Claimed", message: "Your post has been claimed by " + ((itemData!["claimerUsername"] as! String?)!))
                }
            }
            //If current user has no post then alert the user
            else {
                self.alertUser(title: "No Posts", message: "You currently have no active posts")
            }
        }
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: myClaimsActn()
    //
    //    Parameters:
    //    sender: UIButton; The object (UIButton) that will call the function
    //
    //    Pre-condition: This function just requires that the My Claims button was clicked.
    //    Post-condition: First this function will get the current user's email and reference the
    //                    the database. It will compare the claimerEmail in the DB to the current
    //                    email. If they match and it was also claimed, then it will segue to the
    //                    claim screen, otherwise it will alert the user they have no claims.
    //
    //-----------------------------------------------------------------------------------------
    @IBAction func myClaimsActn(_ sender: UIButton) {
        let currentUserEmail = user?.email
        let ref = Database.database().reference()
        ref.child("testItem").observeSingleEvent(of: .value) {
            (snapshot) in
            let itemData = snapshot.value as? [String:Any]
            if (itemData!["claimerEmail"] as! String? == currentUserEmail && itemData!["claimed"] as! Bool? == true) {
                    self.performSegue(withIdentifier: "myClaimsSegue", sender: self)
            }
            else {
                self.alertUser(title: "No Claims", message: "You have no claimed posts.")
            }
        }
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
    //    Post-condition: First this will hide the back button. Then it checks if there is a
    //                    username yet. It then submits a change request and gets the username
    //                    from the usernameString. Then it commits changes and checks for errors.
    //                    If there is an error it will print it, else it will change the usernameLbl's
    //                    text. At the end, outside of the loop, it will store the username to
    //                    usernameLbl's text.
    //-----------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hiding back button
        self.navigationItem.setHidesBackButton(true, animated:true);
        //If no username has been made yet
        if(user?.displayName == nil) {
            //Request change and get username from usernameString
            let changeUsername = user?.createProfileChangeRequest()
            changeUsername?.displayName = usernameString
            //Commit changes
            changeUsername?.commitChanges(completion: { error in
                //If error then print
                if let error = error {
                    print(error)
                //If not then change username
                } else {
                    self.usernameLbl.text = self.user?.displayName
                }
            })
        }
        usernameLbl.text = user?.displayName
    }
}
