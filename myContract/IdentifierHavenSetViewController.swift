//
//  IdentifierHavenSetViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/17.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud

class IdentifierHavenSetViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = LCUser.current!
        let username = user.get("Name")?.jsonString
        let userid = user.get("ID")?.jsonString
        name.text = username?.trimmingCharacters(in: CharacterSet.punctuationCharacters)
        id.text = userid?.trimmingCharacters(in: CharacterSet.punctuationCharacters)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeIdentifier(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        let vc = IDAuthViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
}
