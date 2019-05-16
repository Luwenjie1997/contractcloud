//
//  IdentifierViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/16.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit

class IdentifierViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var showImage: UIButton!
    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    //拍摄
    @IBAction func addFront(_ sender: UIButton) {
        photos()
    }
    
    //保存
    
    @IBAction func saveInformation(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func photos()  {
        
        self.showBottomAlert()
        
    }
    
    func showBottomAlert(){
        
        let alertController=UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel=UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures=UIAlertAction(title:"拍照", style: .default)
        {
            action in
            self.goCamera()
            
        }
        let localPhoto=UIAlertAction(title:"本地图片", style: .default)
        {
            action in
            self.goImage()
            
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        self.present(alertController, animated:true, completion:nil)
        
    }
    
    func goCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            
            print("不支持拍照")
            
        }
        
    }
    
    func goImage(){
        
        
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        print("获得照片============= \(info)")
        
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        //显示设置的照片
        showImage.setTitle("", for: .normal)
        showImage.setImage(image, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func tapGesture(_ sender: Any) {
        userName.resignFirstResponder()
        userID.resignFirstResponder()
    }
}
