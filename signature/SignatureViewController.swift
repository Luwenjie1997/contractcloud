//
//  SignatureViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/25.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit

protocol signatureDelegate {
    func changeImage(image :UIImage)
}

class SignatureViewController: UIViewController,YPSignatureDelegate {
    
    @IBOutlet weak var signature: YPDrawSignatureView!
    var delegate :signatureDelegate?
    var image : UIImage?
    var previousViewController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        signature.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        image = self.signature.getSignature()
        print(image)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyboard.instantiateViewController(withIdentifier: "newContractStoryboard") as? addNewContractViewController
//        VC?.signatureImage = image!
//        self.navigationController?.pushViewController(VC!, animated: true)
        delegate?.changeImage(image: image!)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clear(_ sender: Any) {
        self.signature.clear()
    }
    
    
    func didStart(_ view : YPDrawSignatureView) {
        print("Started Drawing")
    }
    
    // didFinish() is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish(_ view : YPDrawSignatureView) {
        print("Finished Drawing")
    }    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//extension SignatureViewController: UINavigationControllerDelegate {
//
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        if viewController == self.previousViewController {
//            let vc = viewController as! signViewController
//            vc.signatureImage = image
//            print(image)
//        }
//    }
//
//}

