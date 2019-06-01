//
//  VertificationCodeViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/4/30.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud

class VertificationCodeViewController: UIViewController {
    
    var phonenumber : String?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        let label=UILabel(frame:CGRect(origin: CGPoint(x:100,y:100),size: CGSize(width:500,height:500)))
//        label.text = "请输入验证码"
//        label.textColor = #colorLiteral(red: 0, green: 0.7893846631, blue: 1, alpha: 1)
//        label.font=UIFont.systemFont(ofSize: 40)
//        view.addSubview(label)
        let code = CodeView(frame: CGRect(x: 63, y: 400, width: self.view.frame.size.width - 63*2, height: 40))
        //Change Basic Attributes
        
        code.Base.changeViewBasicAttributes(lineColor: UIColor.blue, lineInputColor: UIColor.black, cursorColor: UIColor.red, errorColor: UIColor.red, fontNum: UIFont.systemFont(ofSize: 20), textColor: UIColor.black)
        
        
        
        code.Base.changeInputNum(num: 6)
        
        
        //核对验证码
        code.callBacktext = { str in
            if let result = LCUser.verifyMobilePhoneNumber(self.phonenumber!, verificationCode: str).error {
                print(result)
                let alert = UIAlertController(title: result.reason, message: "请重新输入验证码", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                code.clearnText(error: "error")
            }else{
                let alert = UIAlertController(title: "注册成功", message: "界面将自动跳转至登陆界面", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {action in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(withIdentifier: "myLoginStoryboard") as? LoginViewController
                    self.navigationController?.pushViewController(loginVC!, animated: true)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        view.addSubview(code)
        
    }
}
