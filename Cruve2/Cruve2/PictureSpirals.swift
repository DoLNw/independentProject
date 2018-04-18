//
//  PictureSpirals.swift
//  Cruve2
//
//  Created by 王嘉诚 on 2018/4/7.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit

class PictureSpirals: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var spiralImage: UIImageView!
    //把一组图片的名字放入数组，以对应spirals
    var spiralsName = [String](repeating: "", count: 200)
    var index = 0
    
    @IBAction func addPicture(_ sender: UIBarButtonItem) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("相册不可用")
            return
        }
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker ,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let spiralsName = defaults.object(forKey: "name") as? [String] {
            self.spiralsName = spiralsName
            if index < spiralsName.count-1 {
                let path = getDocumentsDictionary().appendingPathComponent(spiralsName[index])
                spiralImage.image = UIImage(contentsOfFile: path.path)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //注意下面那个key，如果修改过了，用edited，否则originalimage
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        if spiralsName[index] == "" {
            let imageName = UUID().uuidString
            let imagePath = getDocumentsDictionary().appendingPathComponent(imageName)
            
            if let jpegData = UIImageJPEGRepresentation(image, 0.7) {
                try? jpegData.write(to: imagePath)
            }
            spiralsName[index] = imageName
            let defaults = UserDefaults.standard
            defaults.set(spiralsName, forKey: "name")
        } else {
            //防止写入后，因为之前写进去的还是写进去的，这样重名写入的话，直接覆盖了前面的
            let imagePath = getDocumentsDictionary().appendingPathComponent(spiralsName[index])
            if let jpegData = UIImageJPEGRepresentation(image, 0.7) {
                try? jpegData.write(to: imagePath)
            }
        }
        
        spiralImage.image = image
        
        dismiss(animated: true)
    }
    
    func getDocumentsDictionary() ->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDictionary = paths[0]
        return documentsDictionary
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
