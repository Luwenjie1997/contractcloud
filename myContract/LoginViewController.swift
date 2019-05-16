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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let identifier = segue.identifier{
//            switch identifier{
//            case "UserLoginSuccessly" :
//                if let vc = segue.destination as? MainIntViewController{
//                    print("hehehe")
//                }
//            default:
//                break
//            }
//        }
//    }

    @IBOutlet weak var LoginPhoneNumber: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    @IBAction func clickLoginButton(_ sender: Any) {
        let phoneNumber = LoginPhoneNumber.text ?? ""
        let password = LoginPassword.text ?? ""
        LCUser.logIn(mobilePhoneNumber: phoneNumber, password: password){result in
            switch result{
            case .success(let user):
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainInterface")
//                self.navigationController?.pushViewController(vc!, animated: true)
//                break
                let sb = UIStoryboard(name: "Main", bundle: nil)
//                let vc = sb.instantiateViewController(withIdentifier: "tabBarController")
//                self.present(vc, animated: true, completion: nil)
                var vc :MainInterfaceViewController!
                vc = sb.instantiateViewController(withIdentifier: "tabBarController") as! MainInterfaceViewController
                vc.MainUser = user
                self.present(vc, animated: true, completion: nil)
                break
            case .failure(let error):
                print(error)
                
                let alert = UIAlertController(title: "账号密码错误", message: "请重新输入", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                break

            }
//            if (result.error != nil) {
////                print(result.error)
//                let alert = UIAlertController(title: result.error?.failureReason, message: "请重新输入", preferredStyle: .alert)
//                let action = UIAlertAction(title: "确定", style: .default, handler: nil)
//                alert.addAction(action)
//                self.present(alert, animated: true, completion: nil)
//            }else{
//
//            }
        }
        
    }
    
    //取消键盘
    @IBAction func tapGestureController(_ sender: Any) {
        LoginPhoneNumber.resignFirstResponder()
        LoginPassword.resignFirstResponder()
    }
}

