//
//  identity.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/26.
//  Copyright © 2019 lu. All rights reserved.
//

import Foundation
import LeanCloud

@objc class identity :NSObject{
    let user = LCUser.current
//    var name :String
//    var id :String
//
//    init(name :String , id :String) {
//        self.name = name
//        self.id = id
//    }
    
    @objc public func save(withname name :String ,withid id :String) {
        if name != "" && id != ""{
            if DataHandle.shareInstence.IsIdentityCard(id){
                let user = LCUser.current!
                //保存真实姓名和身份证
                try? user.set("Name", value: name)
                try? user.set("ID", value: id)
                user.save(){result in
                    switch result{
                    case .success:
                        print("身份认证成功")
                        break
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
}
