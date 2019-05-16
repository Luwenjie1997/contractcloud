//
//  Contact.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/16.
//  Copyright © 2019 lu. All rights reserved.
//

import Foundation


class Contact: NSObject {
    // 声明属性
    var name : String?
    var phone : String?
    
    // 初始化方法
    init(name : String, phone : String) {
        super.init()
        self.name = name
        self.phone = phone
    }
}
