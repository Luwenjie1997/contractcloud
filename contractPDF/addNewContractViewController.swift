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


class ImageStampAnnotation: PDFAnnotation {
    
    var image: UIImage!
    // A custom init that sets the type to Stamp on default and assigns our Image variable
    init(with image: UIImage!, forBounds bounds: CGRect, withProperties properties: [AnyHashable : Any]?) {
        super.init(bounds: bounds, forType: PDFAnnotationSubtype.stamp, withProperties: properties)
        
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        
        // Get the CGImage of our image
        guard let cgImage = self.image.cgImage else { return }
        
        // Draw our CGImage in the context of our PDFAnnotation bounds
        context.draw(cgImage, in: self.bounds)
        
    }
}

class addNewContractViewController: UIViewController , signatureDelegate {
    func changeImage(image: UIImage) {
        self.signatureImage = image
    }
    

    var _tencentOAuth:TencentOAuth!
    var signatureImage :UIImage?
    var myFile :LCFile?
    var currentlySelectedAnnotation: PDFAnnotation?
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var titleOfAdd: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        _tencentOAuth = TencentOAuth.init(appId: "1105212016", andDelegate: nil)
        self.tabBarController?.tabBar.isHidden = true
        titleOfAdd.text = "本地文件导入"
        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "tint", ofType: "pdf"){
            let url = URL(fileURLWithPath: path)
            if let document = PDFDocument(url: url){
                pdfView.document = document
                pdfView.displayMode = .singlePageContinuous
                pdfView.sizeToFit()
                pdfView.autoScales = true
                button1.isHidden = true
                button2.isHidden = true
                let panAnnotationGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanAnnotation(sender:)))
                pdfView.addGestureRecognizer(panAnnotationGesture)
                
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notify(_:)), name: NSNotification.Name(rawValue: "pdf"), object: nil)
    }
    

    @IBOutlet weak var pdfView: PDFView!
    @objc func notify(_ notification :Notification){
        let str = notification.object
        print(str)
        let url = URL(fileURLWithPath: str as! String)
        if let pdfdocument  = PDFDocument(url: url){
            pdfView.document = pdfdocument
            pdfView.displayMode = .singlePageContinuous
            pdfView.sizeToFit()
            pdfView.autoScales = true
            button1.isHidden = false
            button2.isHidden = false
            pdfView.backgroundColor = UIColor.lightGray
            let panAnnotationGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanAnnotation(sender:)))
            pdfView.addGestureRecognizer(panAnnotationGesture)
            let file = LCFile(payload: .fileURL(fileURL: url))
            myFile = file
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

    @IBAction func send(_ sender: Any) {
        if let url = myFile?.url?.jsonString{
            print(url.trimmingCharacters(in: .punctuationCharacters))
            let newsUrl = URL(string: url.trimmingCharacters(in: .punctuationCharacters))
            let title = "合同标题"
            let description = "合同描述"
            let newsObj = QQApiNewsObject(url: newsUrl, title: title, description: description,
                                          previewImageURL: nil,
                                          targetContentType: QQApiURLTargetTypeNews)
            let req = SendMessageToQQReq(content: newsObj)
            QQApiInterface.send(req)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let signatureImage = signatureImage,
            let page = pdfView.currentPage else { return }
        let pageBounds = page.bounds(for: .cropBox)
        // lets just add the image to the center of the pdf page with a width of 200px and a height of 100 px
        let imageBounds = CGRect(x: pageBounds.midX, y: pageBounds.midY,  width: 200, height: 100)
        // Now we can add our stamp as a annotation of the current pdf page
        let imageStamp = ImageStampAnnotation(with: signatureImage,  forBounds: imageBounds, withProperties: nil)
        page.addAnnotation(imageStamp)
    }
    
    
    @objc func didPanAnnotation(sender: UIPanGestureRecognizer) {
        let touchLocation = sender.location(in: pdfView)
        guard let page = pdfView.page(for: touchLocation, nearest: true)
            else {
                return
        }
        let locationOnPage = pdfView.convert(touchLocation, to:  page)
        switch sender.state {
        case .began:
            guard let annotation = page.annotation(at: locationOnPage) else {   return }
            if annotation.isKind(of: ImageStampAnnotation.self) {
                currentlySelectedAnnotation = annotation
            }
        case .changed:
            guard let annotation = currentlySelectedAnnotation else {return }
            let initialBounds = annotation.bounds
            // Set the center of the annotation to the spot of our finger
            annotation.bounds = CGRect(x: locationOnPage.x - (initialBounds.width / 2), y: locationOnPage.y - (initialBounds.height / 2), width: initialBounds.width, height: initialBounds.height)
        case .ended, .cancelled, .failed:
            currentlySelectedAnnotation = nil
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSignatureSegue" {
            if let nextVC = segue.destination as? SignatureViewController {
                nextVC.delegate = self
            }
        }
    }
}
