//
//  Project Name: Leftovers
//  Description: An application to list and claim free "Leftover" items
//  File Name: PostItemViewController.swift
//  Description: View Controller file for the post item view
//  Last modified on: 4/24/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import Firebase

class PostItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    //UIimage, button, and textfields on the screen
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemDesc: UITextView!
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: postFunc()
    //
    //    Parameters:
    //    sender: UIButton; this is the object (a button) that calls this function
    //
    //    Pre-condition: This function just requires that the post button was clicked.
    //    Post-condition: First checks that all fields are filled in and then stores the item data
    //                    to the database. Then it stores the username and email data to the DB.
    //                    Aftwards it segues to the item detail view. If all fields weren't filled
    //                    in then user is given an alert.
    //
    //-----------------------------------------------------------------------------------------
    @IBAction func postFunc(_ sender: UIButton){
        //If all fields are filled in
        if itemName.text != "" && itemDesc.text != "" && postImage.image != nil{
            //Store to database
            let ref = Database.database().reference()
            ref.child("testItem/itemName").setValue(itemName.text)
            ref.child("testItem/itemDescription").setValue(itemDesc.text)
            ref.child("testItem/claimed").setValue(false)
            
            //Getting current user email and username to store to database
            let user = Auth.auth().currentUser
            ref.child("testItem/posterUsername").setValue(user?.displayName!)
            ref.child("testItem/posterEmail").setValue(user?.email!)
            
            //Segue to item details view
            performSegue(withIdentifier: "itemDetailSegue", sender: self)
        }
        //Else if all fields all aren't filled in, alert the user
        else {
            self.alertUser(title: "Missing Information", message: "Please fill out all fields.")
        }
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: insertImageFunc()
    //
    //    Parameters:
    //    sender: UIButton; this is the object (a button) that calls this function
    //
    //    Pre-condition: This function just requires that the insert image button was clicked.
    //    Post-condition: This brings up the image picker and lets the user choose an image
    //                    from their photo library.
    //
    //-----------------------------------------------------------------------------------------
    @IBAction func insertImageFunc(_ sender: UIButton){
        //Initializing image picker
        let image = UIImagePickerController()
        image.delegate = self
        
        //Where the user can get the image from (library)
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        //Editing not needed and present to user
        image.allowsEditing = false;
        self.present(image, animated: true){
        }
        
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: imagePickerController()
    //
    //    Parameters:
    //    picker: UIImagePickerController; Image picker object from previous function
    //    didFinishPickingMediaWithInfo info: UIImagePickerController.InfoKey; the info from
    //                                        that picker
    //
    //    Pre-condition: Valid UIImage picker and UIImage picker info.
    //    Post-condition: This will checker if it can be interpreted as UIImage, then store that
    //                    image to the postImage UIImage on screen, else it will alert the user
    //                    of an error. Then it will dismiss the picker and call the store image
    //                    to Firebase function.
    //
    //-----------------------------------------------------------------------------------------
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Check if its possible
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //Set UIImage to selected image
            postImage.image = image
        }
        //Else will alert user
        else {
            self.alertUser(title: "Image Choosing Failed", message: "Please try again.")
        }
        self.dismiss(animated:true, completion: nil)
        
        //Calling store image to Firebase function
        self.storeImageToFirebase(picName: "itemImage.png", databasePathForURL : "testItem/imageURL")
    }
    
    //Default function with nothing added, which is automatically put in here by Xcode in all UIViewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //-----------------------------------------------------------------------------------------
    //
    //  Function: storeImageToFirebase()
    //
    //    Parameters:
    //    picName: String; Name you want to give the picture, include file extension
    //    databasePathForURL: String; Path in database that you want to store the image URL to
    //
    //    Pre-condition:  The image has been loaded in using the picker, and picName and that
    //                    databasePathForURL are valid.
    //    Post-condition: First it will call to the storage and prepare the picture as a PNG. Then
    //                    it will put that data into storage and catch an error, alerting the user.
    //                    Lastly it will take the URL from the metadata of the store picture and
    //                    store that into the parameter specified DB location.
    //
    //-----------------------------------------------------------------------------------------
    func storeImageToFirebase (picName : String, databasePathForURL: String) {
        //Storing image on Firebase storage
        let storageRef = Storage.storage().reference().child(picName)
        let uploadData = postImage.image?.pngData()
        
        //Putting image into storage
        storageRef.putData(uploadData!, metadata: nil, completion: {(metadata, error) in
            if error != nil {
                self.alertUser(title: "Image Upload Failed", message: "Please try again.")
                return
            }
            //Storing image url in database
            let ref = Database.database().reference()
            ref.child(databasePathForURL).setValue(metadata?.downloadURL()?.absoluteString)
        })
    }
}
