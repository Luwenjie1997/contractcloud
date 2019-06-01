//
//  MineViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/16.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud

class MineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "Contact":
                print("contact")
            default:break
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    @IBAction func identifier(_ sender: UIButton) {
        let user = LCUser.current!
        if let name = user.get("Name") , let id = user.get("ID"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "IdentifierHavenSet") as? IdentifierHavenSetViewController
            self.navigationController?.pushViewController(VC!, animated: true)
        }else{
            self.tabBarController?.tabBar.isHidden = true
            let vc = IDAuthViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
