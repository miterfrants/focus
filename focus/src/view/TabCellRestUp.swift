//
//  TabCellRestUp.swift
//  focus
//
//  Created by Po-Hsiang Huang on 2014/10/27.
//  Copyright (c) 2014年 Po-Hsiang Huang. All rights reserved.
//

import Foundation
import UIKit
class TabCellRestUp: UITableViewCell
{
    internal var btnBg:UIButton = UIButton()
    internal var switchRestUp = UISwitch()
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
        self.textLabel.text = "Rest Up"
        self.textLabel.textColor = Global.Color.Content
        self.textLabel.font = Global.Font.Content
        var size = textLabel.sizeThatFits(CGSize(width: UIScreen.mainScreen().bounds.size.width, height: self.frame.size.height))
        
        btnBg.frame = CGRect(x:0, y:0, width:UIScreen.mainScreen().bounds.size.width, height:self.bounds.size.height)
        self.addSubview(btnBg)
        
        switchRestUp.frame.origin.x = UIScreen.mainScreen().bounds.size.width - Global.Geometry.TabPanddingRight - switchRestUp.frame.size.width
        switchRestUp.frame.origin.y = (self.bounds.size.height - switchRestUp.bounds.size.height) / 2
        switchRestUp.onTintColor = Global.Color.SwitchOnTintColor
        self.addSubview(switchRestUp)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}