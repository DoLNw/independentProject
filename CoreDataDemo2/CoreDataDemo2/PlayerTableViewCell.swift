//
//  PlayerTableViewCell.swift
//  CoreDataDemo2
//
//  Created by 王嘉诚 on 2018/3/28.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        picture.layer.cornerRadius = 20
        //注：1、为了给图片加阴影，需要maskstobound为false，但是这样图片也超出了，再加一个view放在image的下面来解决（这个很重要）。2、一开始cell行高不足，是因为cell的行高设置了，而tableview的也要设置。3、一开始cell上的图片不对，是因为虽然as转换了，但是我用了cell。imareview属性，没有使用它的我自己关联的picture属性。
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 2.5
//        picture.layer.masksToBounds = false
        
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        nameLabel.layer.shadowOpacity = 0.3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
