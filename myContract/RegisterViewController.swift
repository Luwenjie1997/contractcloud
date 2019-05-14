//
//  RegisterViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/4/29.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "passPhoneNumber" :
                if let vc = segue.destination as? VertificationCodeViewController{
                    if let phonenumber = registerPhoneNumber.text{
                        vc.phonenumber = phonenumber
                        print(vc.phonenumber!)
                    }
                }
            default : break
            }
        }
    }
 
    
    
    @IBOutlet weak var registerPhoneNumber: UITextField!
    @IBOutlet weak var RegisterPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userID: UITextField!
    
    @IBAction func clickRegisterButton(_ sender: UIButton) {
        let phoneNumber = registerPhoneNumber.text ?? ""
        let password = RegisterPassword.text ?? ""
        if phoneNumber.count == 11 {
            if password.count >= 8 && password.count <= 16 {
                let user = LCUser()
                user.username = LCString(phoneNumber)
                user.mobilePhoneNumber = LCString(phoneNumber)
                user.password = LCString(password)
                if let result = user.signUp().error{
                    showDetail(first: "注册失败", second: result.reason ?? "ok")
                }else{
//                    let vertifyViewController = VertificationCodeViewController()
//                    vertifyViewController.phonenumber = phoneNumber
//                    self.navigationController?.pushViewController(vertifyViewController, animated: true)
                }
            }else{
                showDetail(first: "密码无效", second: "请输入8-16位密码")
            }
        }else {
            showDetail(first: "手机号无效", second: "请输入11位手机号")
        }
        
    }
    
    private func showDetail (first alertTitle :String , second alertMessage :String ){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
