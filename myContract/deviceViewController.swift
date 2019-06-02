//
//  deviceViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/6/3.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit

class deviceViewController: UIViewController {

    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var uuid: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        uuid.text = UIDevice.current.identifierForVendor?.uuidString
        deviceName.text = UIDevice.current.name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
