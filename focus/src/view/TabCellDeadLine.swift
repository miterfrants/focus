//
//  TabCellDeadLine.swift
//  focus
//
//  Created by Po-Hsiang Huang on 2014/10/27.
//  Copyright (c) 2014年 Po-Hsiang Huang. All rights reserved.
//

import Foundation
import UIKit
class TabCellDeadLine: UITableViewCell
{
    internal var lblTime:UILabel = UILabel()
    internal var lblTitle:UILabel = UILabel()
    internal var btnBg:UIButton = UIButton()
    internal var picker = UIDatePicker()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init()
    {
        super.init()
        lblTitle.text = "Deadline"
        lblTitle.textColor = Global.Color.Content
        lblTitle.font = Global.Font.Content
        lblTitle.frame = CGRect(x:Global.Geometry.TabPanddingLeft, y:0, width:200, height:44)
        var size = lblTitle.sizeThatFits(CGSize(width: UIScreen.mainScreen().bounds.width, height: 44))
        lblTitle.frame.size.width = size.width
        self.addSubview(lblTitle)
        
        btnBg.frame = CGRect(x:0, y:0, width:UIScreen.mainScreen().bounds.size.width, height:self.bounds.size.height)
        btnBg.tintColor = UIColor.lightGrayColor()
        self.addSubview(btnBg)

        picker.frame.origin.x = (UIScreen.mainScreen().bounds.width - picker.frame.size.width) / 2
        picker.frame.origin.y = self.bounds.height
        picker.hidden = true
        self.contentView.addSubview(picker)

        lblTime.textColor = Global.Color.Content
        lblTime.text = "1 hours later"
        lblTime.textAlignment = NSTextAlignment.Right
        lblTime.font = Global.Font.Content
        lblTime.frame.size.height = self.frame.size.height
        lblTime.frame.size.width = UIScreen.mainScreen().bounds.size.width - size.width - Global.Geometry.TabPanddingRight - Global.Geometry.TabPanddingLeft
        lblTime.frame.origin.x = size.width + Global.Geometry.TabPanddingLeft
        lblTime.frame.origin.y = 0
        self.addSubview(lblTime)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
}