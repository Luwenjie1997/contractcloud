//
//  ViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/4/27.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud

class LoginViewController: UIViewController {

    override func viewDidLoad() {
//        LoginPhoneNumber.layer.borderColor = #colorLiteral(red: 0, green: 0.7893846631, blue: 1, alpha: 1)
//        LoginPassword.layer.borderColor = #colorLiteral(red: 0, green: 0.7893846631, blue: 1, alpha: 1)
        
        
    }

    @IBOutlet weak var LoginPhoneNumber: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    @IBAction func clickLoginButton(_ sender: Any) {
        let phoneNumber = LoginPhoneNumber.text ?? ""
        let password = LoginPassword.text ?? ""
        LCUser.logIn(mobilePhoneNumber: phoneNumber, password: password){result in
            switch result{
            case .success(let user):
                break
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "账号密码错误", message: "请重新输入", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    
    //取消键盘
    @IBAction func tapGestureController(_ sender: Any) {
        LoginPhoneNumber.resignFirstResponder()
        LoginPassword.resignFirstResponder()
    }
}

