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
        if DataHandle.shareInstence.isPhoneNumber(phoneNumber: phoneNumber) {
            if DataHandle.shareInstence.isPasswordRuler(password: password) {
                let user = LCUser()
                user.username = LCString(phoneNumber)
                user.mobilePhoneNumber = LCString(phoneNumber)
                user.password = LCString(password)
                if let result = user.signUp().error{
                    self.showDetail(first: "注册失败", second: result.reason ?? "ok")
                }else{
//                    let vertifyViewController = VertificationCodeViewController()
//                    vertifyViewController.phonenumber = phoneNumber
//                    self.navigationController?.pushViewController(vertifyViewController, animated: true)
                }
            }else{
                self.showDetail(first: "密码无效", second: "6-8位字母和数字组合")
            }
        }else {
            self.showDetail(first: "手机号无效", second: "请输入有效的11位手机号")
        }
        
    }
    
//    private func showDetail (first alertTitle :String , second alertMessage :String ){
//        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
//        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
    
//    //判断手机号是否有效
//    private func isPhoneNumber(phoneNumber:String) -> Bool {
//        if phoneNumber.count == 0 {
//            return false
//        }
//        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
//        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
//        if regexMobile.evaluate(with: phoneNumber) == true {
//            return true
//        }else
//        {
//            return false
//        }
//    }
    
//    private func isPasswordRuler(password:String) -> Bool {
//        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,8}$"
//        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
//        if regexPassword.evaluate(with: password) == true {
//            return true
//        }else
//        {
//            return false
//        }
//    }
    
    
    
    @IBAction func tapGestureController(_ sender: Any) {
        registerPhoneNumber.resignFirstResponder()
        RegisterPassword.resignFirstResponder()
    }
}
