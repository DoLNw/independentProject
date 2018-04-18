//
//  AddPlayersViewController.swift
//  CoreDataDemo2
//
//  Created by 王嘉诚 on 2018/3/28.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit
import CoreData

class AddPlayersViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    //注意要over current view才可以显示后面的图

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var numInput: UITextField!
    @IBOutlet weak var pictureBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    var notification: NotificationCenter!
    var numInputRect: CGRect? = nil
    var nameInoutRect: CGRect? = nil
    var picBtnRect: CGRect? = nil
    var saveBtnRect: CGRect? = nil
    var nameLabelRect: CGRect? = nil
    var numLabelRect: CGRect? = nil
    var cancelBtnRect: CGRect? = nil
    
    //点击外部收起虚拟键盘
    @IBAction func tapSomething(_ sender: Any) {
        self.view.endEditing(true)
        //或者下面这个试试
//        @IBOutlet weak var tf: UITextField!

//        @IBAction func viewClick(_ sender: Any) {
//            tf.resignFirstResponder()
//        }
    }
    
    @IBAction func tapBlank(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func choosePicture(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("相册不可用")
            return
        }
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
        
        picker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        pictureBtn.setImage(info[UIImagePickerControllerOriginalImage] as? UIImage, for: .normal)
//        pictureBtn.imageView?.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        pictureBtn.imageView?.contentMode = .scaleAspectFill
        pictureBtn.imageView?.clipsToBounds = true
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if nameInput.text != "" {
            if let num = Int16(numInput.text!) {
                if let image = pictureBtn.imageView?.image {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let player = Mood(context: appDelegate.persistentContainer.viewContext)
                    
                    player.name = nameInput.text!
                    player.number = num
                    let imagedata = UIImageJPEGRepresentation(image, 0.7)
                    player.image = imagedata
                    appDelegate.saveContext()
                    self.dismiss(animated: true)
                    return
                }
            }
        }
        //其实这里self.dismiss也可以吧，就不用在前一个controller里面写@IBaction segue那个，然后让我的这个button去关联exit里面的了，此处放在了action里面（由于某些原因）
        let ac = UIAlertController(title: "无效的输入", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        ac.addAction(action)
        self.present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardDidHide, object: nil)
        
        numInputRect = numInput.frame
        nameInoutRect = nameInput.frame
        picBtnRect = pictureBtn.frame
        saveBtnRect = saveBtn.frame
        nameLabelRect = nameLabel.frame
        numLabelRect = numLabel.frame
        cancelBtnRect = cancelBtn.frame
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = view.convert(keyboardScreenEndFrame, to: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillShow {
            guard pictureBtn.frame.origin.y != picBtnRect!.origin.y - keyboardEndFrame.size.height else { return }
            
            nameInput.frame.origin.y = nameInoutRect!.origin.y - keyboardEndFrame.size.height + 55.0
            numInput.frame.origin.y = numInputRect!.origin.y - keyboardEndFrame.size.height + 55.0
            saveBtn.frame.origin.y = saveBtnRect!.origin.y - keyboardEndFrame.size.height + 55.0
            pictureBtn.frame.origin.y = picBtnRect!.origin.y - keyboardEndFrame.size.height + 55.0
            nameLabel.frame.origin.y = nameLabelRect!.origin.y - keyboardEndFrame.size.height + 55.0
            numLabel.frame.origin.y = numLabelRect!.origin.y - keyboardEndFrame.size.height + 55.0
            cancelBtn.frame.origin.y = cancelBtnRect!.origin.y - keyboardEndFrame.size.height + 55.0
            
        } else if notification.name == Notification.Name.UIKeyboardDidHide {
            nameInput.frame = nameInoutRect!
            numInput.frame = numInputRect!
            saveBtn.frame = saveBtnRect!
            pictureBtn.frame = picBtnRect!
            nameLabel.frame = nameLabelRect!
            numLabel.frame = numLabelRect!
            cancelBtn.frame = cancelBtnRect!
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
