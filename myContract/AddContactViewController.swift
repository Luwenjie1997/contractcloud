//
//  AddContactViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/16.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
    
//    // 要修改的联系人信息
//    var contact : Contact?
//    // 要修改的联系人下标
//    var index : Int?
//
//    // 重定义，相当于typedef
//    typealias BLOCK = () -> Void
//    // 声明一个闭包属性
//    var myBlock : BLOCK?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var NewContactName: UITextField!
    @IBOutlet weak var NewContactPhone: UITextField!
    @IBAction func clickButton(_ sender: Any) {
        let name = NewContactName.text ?? ""
        let phone = NewContactPhone.text ?? ""
        
        if name != "" && phone != ""{
            if DataHandle.shareInstence.isPhoneNumber(phoneNumber: phone){
                let newContact = Contact.init(name: name, phone: phone)
                DataHandle.shareInstence.addContactToArray(contact: newContact)
                showDetail(first: "添加成功", second: "")
                print(DataHandle.shareInstence.contactArray)
            }else{
                showDetail(first: "手机号无效", second: "请输入11位有效手机号")
            }
        }else{
            showDetail(first: "姓名或手机号为空", second: "请输入姓名和手机号")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func showDetail (first alertTitle :String , second alertMessage :String ){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func tapGesture(_ sender: Any) {
        NewContactName.resignFirstResponder()
        NewContactPhone.resignFirstResponder()
    }
}
