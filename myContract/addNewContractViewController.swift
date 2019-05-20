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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(notify(_:)), name: NSNotification.Name(rawValue: "pdf"), object: nil)
    }
    

    @IBOutlet weak var pdfView: PDFView!
    @objc func notify(_ notification :Notification){
        print("call")
        let str = notification.object
        let url = URL(fileURLWithPath: str as! String)
        if let pdfdocument  = PDFDocument(url: url){
            pdfView.document = pdfdocument
            let file = LCFile(payload: .fileURL(fileURL: url))
            let userPhone = DataHandle.shareInstence.currentUser!.mobilePhoneNumber!.jsonString.trimmingCharacters(in: .punctuationCharacters)
            try?file.set("user", value: userPhone)
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
