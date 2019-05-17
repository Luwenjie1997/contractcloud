//
//  ContactTableViewCell.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/18.
//  Copyright © 2019 lu. All rights reserved.
//

import Contacts
import UIKit

class ContactTableViewCell: UITableViewCell {
    // outlets
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCircularAvatar() {
        contactImageView.layer.cornerRadius = contactImageView.bounds.size.width / 2.0
        contactImageView.layer.masksToBounds = true
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setCircularAvatar()
    }
    
    func configureWithContactEntry(_ contact: ContactEntry) {
        contactNameLabel.text = contact.name
        contactPhoneLabel.text = contact.phone ?? ""
        contactImageView.image = contact.image ?? UIImage(named: "defaultUser")
        setCircularAvatar()
    }
}

