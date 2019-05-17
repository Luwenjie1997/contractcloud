//
//  DataHandle.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/16.
//  Copyright © 2019 lu. All rights reserved.
//

import Foundation
import LeanCloud

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
    
    //判断身份证是否有效
    func IsIdentityCard(_ identityCard: String) -> Bool {
        //判断是否为空
        if identityCard.count <= 0 {
            return false
        }
        //判断是否是18位，末尾是否是x
        let regex2: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@", regex2)
        if !identityCardPredicate.evaluate(with: identityCard) {
            return false
        }
        //判断生日是否合法
        let range = NSRange(location: 6, length: 8)
        let datestr: String = (identityCard as NSString).substring(with: range)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        if formatter.date(from: datestr) == nil {
            return false
        }
        //判断校验位
        if  identityCard.count == 18 {
            let idCardWi: [String] = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"]
            //将前17位加权因子保存在数组里
            let idCardY: [String] = ["1", "0", "10", "9", "8", "7", "6", "5", "4", "3", "2"]
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            var idCardWiSum: Int = 0
            //用来保存前17位各自乖以加权因子后的总和
            for i in 0..<17 {
                idCardWiSum += Int((identityCard as NSString).substring(with: NSRange(location: i, length: 1)))! * Int(idCardWi[i])!
            }
            let idCardMod: Int = idCardWiSum % 11
            //计算出校验码所在数组的位置
            let idCardLast: String = identityCard.substring(from: identityCard.index(identityCard.endIndex, offsetBy: -1))
            //得到最后一位身份证号码
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if idCardMod == 2 {
                if idCardLast == "X" || idCardLast == "x" {
                    return true
                } else {
                    return false
                }
            } else {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if (idCardLast as NSString).integerValue == Int(idCardY[idCardMod]) {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
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
