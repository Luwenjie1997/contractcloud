//
//  CreateContactViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/18.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import Contacts

//enum ContactType {
//    case addressBookContact
//    case cnContact
//}

class CreateContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // outlets
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    
    // data
    //    var type: ContactType?
    var contactImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contactImageView.layer.cornerRadius = contactImageView.frame.size.width / 2.0
        contactImageView.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @available(iOS 9.0, *)
    func createCNContactWithFirstName(_ firstName: String, lastName: String, phone: String?, image: UIImage?) {
        // create contact with mandatory values: first and last name
        let newContact = CNMutableContact()
        newContact.givenName = firstName
        newContact.familyName = lastName
        
        // phone
        if phone != nil {
            let contactPhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: phone!))
            newContact.phoneNumbers = [contactPhone]
        }
        
        //        // image
        //        if image != nil {
        //            newContact.imageData = UIImageJPEGRepresentation(image!, 0.9)
        //        }
        
        do {
            let newContactRequest = CNSaveRequest()
            newContactRequest.add(newContact, toContainerWithIdentifier: nil)
            try CNContactStore().execute(newContactRequest)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } catch {
            self.showAlertMessage("I was unable to create the new contact. An error occurred.")
        }
    }
    
    // MARK: - Button actions
    @IBAction func createContact(_ sender: AnyObject) {
        // check if we can create a contact.
        if let firstName = firstNameTextfield.text , firstName.count > 0,
            let lastName = lastNameTextfield.text , lastName.count > 0 {
            let phone = phoneNumberTextfield.text
            if #available(iOS 9, *) {
                createCNContactWithFirstName(firstName, lastName: lastName, phone: phone, image: contactImage)
            } else {
                self.showAlertMessage("Sorry, you can only use the Contacts framework from iOS 9.")
            }
        }
        else {
            self.showAlertMessage("Please, insert at least a first and last name for the contact.")
        }
    }
    
    
    @IBAction func goBack(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

