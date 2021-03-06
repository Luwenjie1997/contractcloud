//
//  pdfViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/20.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import PDFKit
import LeanCloud

class pdfViewController: UIViewController {
    
    
    public var document :PDFDocument?
    @IBOutlet weak var pdfView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.document = document
        pdfView.displayMode = .singlePageContinuous
        pdfView.sizeToFit()
        pdfView.autoScales = true
        NotificationCenter.default.addObserver(self, selector: #selector(notify(_:)), name: NSNotification.Name(rawValue: "pdf"), object: nil)
        // Do any additional setup after loading the view.
        //        if let string = urlstring{
        //            let url = URL(fileURLWithPath: string)
        //            pdfView.document = PDFDocument(url: url)
        //            print(string)
        //        }else{
        //            print("no string")
        //        }
        
        
    }
    
    @objc func notify(_ notification :Notification){
        print("call")
        let str = notification.object
        let url = URL(fileURLWithPath: str as! String)
        if let pdfdocument  = PDFDocument(url: url){
            pdfView.document = pdfdocument
            pdfView.displayMode = .singlePageContinuous
            pdfView.sizeToFit()
            pdfView.autoScales = true
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

