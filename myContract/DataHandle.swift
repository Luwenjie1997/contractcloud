//
//  DataHandle.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/16.
//  Copyright © 2019 lu. All rights reserved.
//

import Foundation

class DataHandle: NSObject {
    var contactArray = Array<Contact>()
    // 声明计算属性
    var count : Int {
        get {
            return contactArray.count
        }
    }
    
    static let shareInstence = DataHandle()
    
    // 单例
    // 为了防止在外部被再次初始化
    private override init() {
        super.init()
    }
    
    
    //判断手机号是否有效
    func isPhoneNumber(phoneNumber:String) -> Bool {
        if phoneNumber.count == 0 {
            return false
        }
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true {
            return true
        }else
        {
            return false
        }
    }
    
    //判断密码是否有效
    func isPasswordRuler(password:String) -> Bool {
        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,8}$"
        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
        if regexPassword.evaluate(with: password) == true {
            return true
        }else
        {
            return false
        }
    }
    
    // MARK: - 添加联系人
    func addContactToArray (contact : Contact) {
        self.contactArray.append(contact)
    }
    
    // MARK: - 根据下标获取联系人
    func findContactWithIndex (index : Int) -> Contact {
        return self.contactArray[index]
    }
    
    // MARK: - 更新联系人信息
    func updataContactWithIndex (newContact : Contact, index : Int) -> Void {
        self.contactArray.remove(at: index)
        self.contactArray.insert(newContact, at: index)
    }
    
    // MARK: - 删除联系人
    func removeContactWithIndex (index : Int) -> Void {
        self.contactArray.remove(at: index)
    }
    
    // MARK: - 移动
    func changeContact (fromIndexPath : Int, toIndexPath : Int) {
        let contact = self.contactArray[fromIndexPath]
        self.contactArray.remove(at: fromIndexPath)
        
        self.contactArray.insert(contact, at: toIndexPath)
    }
}
