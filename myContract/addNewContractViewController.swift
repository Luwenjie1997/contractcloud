//
//  addNewContractViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/20.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud
import PDFKit

class addNewContractViewController: UIViewController {

    
    @IBOutlet weak var titleOfAdd: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleOfAdd.text = "本地文件导入"
        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "tint", ofType: "pdf"){
            let url = URL(fileURLWithPath: path)
            if let document = PDFDocument(url: url){
                pdfView.document = document
                pdfView.displayMode = .singlePageContinuous
                pdfView.sizeToFit()
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notify(_:)), name: NSNotification.Name(rawValue: "pdf"), object: nil)
    }
    

    @IBOutlet weak var pdfView: PDFView!
    @objc func notify(_ notification :Notification){
        print("call")
        let str = notification.object
        print(str)
        let url = URL(fileURLWithPath: str as! String)
        if let pdfdocument  = PDFDocument(url: url){
            pdfView.document = pdfdocument
            let file = LCFile(payload: .fileURL(fileURL: url))
            let userPhone = DataHandle.shareInstence.currentUser!.mobilePhoneNumber!.jsonString.trimmingCharacters(in: .punctuationCharacters)
            try?file.set("user", value: userPhone)
            //Isigned代表我是否签名，heSign代表对方是否签名，0是未签，1是已签
            try?file.set("iSigne", value: 1)
            try?file.set("heSign", value: 0)
            file.save(
                progress: { progress in
                    print(progress)
            },
                completion: { result in
                    switch result {
                    case .success:
                        break
                    case .failure(let error):
                        print(error.reason ?? "")
                        break
                    }
            })
        }
    }

}
