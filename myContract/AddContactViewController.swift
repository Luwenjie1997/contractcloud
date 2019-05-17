//
//  AddContactViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/16.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
    

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
                print(DataHandle.shareInstence.contactArray)
                let alert = UIAlertController(title: "保存成功", message: "界面将自动跳转至联系人界面", preferredStyle: .alert)
                let action = UIAlertAction(title: "确定", style: .default, handler: {action in
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let VC = storyboard.instantiateViewController(withIdentifier: "MyContactListStoryboeard") as! ContactListTableViewController
//                    print(VC)
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
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
