//
//  ContactEntry.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/18.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import Contacts

class ContactEntry: NSObject {
    var name: String!
    var phone: String?
    var image: UIImage?
    
    init(name: String, phone: String?, image: UIImage?) {
        self.name = name
        self.phone = phone
        self.image = image
    }
    
    
    @available(iOS 9.0, *)
    init?(cnContact: CNContact) {
        // name
        if !cnContact.isKeyAvailable(CNContactGivenNameKey) && !cnContact.isKeyAvailable(CNContactFamilyNameKey) { return nil }
        self.name = (cnContact.givenName + " " + cnContact.familyName).trimmingCharacters(in: CharacterSet.whitespaces)
        // image
        self.image = (cnContact.isKeyAvailable(CNContactImageDataKey) && cnContact.imageDataAvailable) ? UIImage(data: cnContact.imageData!) : nil
        // phone
        if cnContact.isKeyAvailable(CNContactPhoneNumbersKey) {
            if cnContact.phoneNumbers.count > 0 {
                let phone = cnContact.phoneNumbers.first?.value
                self.phone = phone?.stringValue
            }
        }
    }
}

