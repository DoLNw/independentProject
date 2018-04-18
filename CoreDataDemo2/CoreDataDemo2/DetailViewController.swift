//
//  DetailViewController.swift
//  CoreDataDemo2
//
//  Created by 王嘉诚 on 2018/3/30.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageData: Data!
    var titleName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleName
        imageView.image = UIImage(data: imageData)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //这句那些标题、返回也没了
//        self.navigationController?.navigationBar.alpha = 0.1
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
