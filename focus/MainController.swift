//
//  ViewController.swift
//  focus
//
//  Created by Po-Hsiang Huang on 2014/10/23.
//  Copyright (c) 2014年 Po-Hsiang Huang. All rights reserved.
//

import UIKit
import Foundation

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    enum TabType:Int
    {
        case MAIN = 0
        case LIST = 1
    }
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tabList: UITableView!
    @IBOutlet weak var tabForm: UITableView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnList: UIButton!
    var dicTabItem: Dictionary<TabType, UIButton>!
    var dicTabContent: Dictionary<TabType, UIView>!
    var currentTabType: TabType!
    var textTaskTitle: UITextField!
    var lblTimePeriod: UILabel!
    var tap: UIGestureRecognizer!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabForm.dataSource = self
        self.tabForm.delegate = self
        
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        
        currentTabType = TabType.MAIN
        
        btnAdd.tag = TabType.MAIN.rawValue
        btnList.tag = TabType.LIST.rawValue
        
        dicTabItem = Dictionary<TabType, UIButton>()
        dicTabContent = Dictionary<TabType, UIView>()
        
        dicTabItem[TabType.MAIN] = btnAdd
        dicTabItem[TabType.LIST] = btnList
        
        dicTabContent[TabType.MAIN] = viewMain
        dicTabContent[TabType.LIST] = tabList
        
        tabList.backgroundColor = UIColor.lightGrayColor()
        tabForm.scrollEnabled = false
        
        var btnStartLayer = CAShapeLayer()
        btnStartLayer.path = Global.Geometry.BtnStartCGPath()
        btnStart.layer.mask = btnStartLayer
        btnStart.backgroundColor = Global.Color.BtnStartFill
        btnStart.setTitleColor(Global.Color.BtnStartHighLightFill, forState: UIControlState.Highlighted)
        btnStart.setTitleColor(Global.Color.BtnStartHighLightFill, forState: UIControlState.Selected)
    }
    
    func addTapOutsideRecognizer(sender:AnyObject){
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(sender: AnyObject) {
        if !sender.isEqual(textTaskTitle) {
            textTaskTitle.resignFirstResponder()
        }
    }
    
    func getTabBtnImageName(type: TabType) -> String
    {
        switch type{
        case .MAIN:
            return "btn_add"
        case .LIST:
            return "btn_list"
        default:
            return ""
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnTapHandler(sender: AnyObject)
    {
        let btn = sender as UIButton
        slide(TabType(rawValue: btn.tag)!)
    }
    
    func slide(tabType:TabType)
    {
        if tabType == currentTabType {
            return
        }
        for type in self.dicTabItem.keys {
            var btn = (self.dicTabItem[type as TabType!] as UIButton!)
            var selected = ""
            if type == tabType {
                selected = "_hover"
            }
            btn.setImage(UIImage(named: self.getTabBtnImageName(type) + selected), forState: UIControlState.Normal)
            btn.setImage(UIImage(named: self.getTabBtnImageName(type) + selected), forState: UIControlState.Highlighted)
            btn.setImage(UIImage(named: self.getTabBtnImageName(type) + selected), forState: UIControlState.Selected)
        }
        currentTabType = tabType
        let screenW: CGFloat = UIScreen.mainScreen().bounds.size.width

        UIView.animateWithDuration(0.28, delay: 0, options: .CurveEaseOut, animations: {
            for type in self.dicTabContent.keys {
                var target = (self.dicTabContent[type as TabType!] as UIView!)
                target.frame.origin.x = CGFloat(Float(-1)*Float(self.currentTabType.hashValue-type.hashValue)*Float(screenW));
            }
            }, completion: nil)
    }
    
    /* table start */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView.isEqual(self.tabForm)
        {
            return Global.Num.TabCellOfForm
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return CGFloat(Global.Geometry.TabHeaderHeight)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return Global.Geometry.TabCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell
        switch (indexPath.row) {
            case 0:
                cell = TabCellRestUp()
                (cell as TabCellRestUp).btnBg.addTarget(self, action: "switchSwitchRestUp:", forControlEvents: UIControlEvents.TouchUpInside)
                break
            case 1:
                cell = TabCellDeadLine()
                (cell as TabCellDeadLine).btnBg.addTarget(self, action: "switchPickerTime:", forControlEvents: UIControlEvents.TouchUpInside)
                (cell as TabCellDeadLine).picker.addTarget(self, action: "handlePickerTime:", forControlEvents: UIControlEvents.ValueChanged)
                (cell as TabCellDeadLine).picker.setDate(NSDate().dateByAddingTimeInterval(60*60), animated: false)
                break
            default:
                cell = UITableViewCell()
                break
        }
        var bottomBorder:UIView
        if indexPath.row < Global.Num.TabCellOfForm - 1 {
            bottomBorder = UIView(frame: CGRect(x: Global.Geometry.TabPanddingLeft, y: Global.Geometry.TabCellHeight, width: UIScreen.mainScreen().bounds.size.width - Global.Geometry.TabPanddingLeft, height: 1))
            bottomBorder.backgroundColor = Global.Color.TabSeperate
        } else {
            bottomBorder = UIView(frame: CGRect(x: 0, y: Global.Geometry.TabCellHeight, width: UIScreen.mainScreen().bounds.size.width , height: 1))
            bottomBorder.backgroundColor = Global.Color.TabSeperate
        }
        cell.addSubview(bottomBorder)
        return cell
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView.isEqual(self.tabForm)
        {
            var header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: Global.Geometry.TabHeaderHeight))
            
            var title = UITextField(frame: CGRect(x: Global.Geometry.TabPanddingLeft, y: Global.Geometry.TabHeaderHeight-Global.Geometry.TabHeaderTextHeight, width: UIScreen.mainScreen().bounds.size.width, height: Global.Geometry.TabHeaderTextHeight))
            title.text = "TASK:"
            title.font = Global.Font.Title
            title.textColor = Global.Color.Title
            title.enabled = false
            var size = title.sizeThatFits(CGSize(width: 200, height: Global.Geometry.TabHeaderHeight))
            title.frame.size.width = size.width
            header.addSubview(title)
            
            textTaskTitle = UITextField(frame: CGRect(
                x: Global.Geometry.TabPanddingLeft + size.width + Global.Geometry.TabPanddingLeft,
                y: Global.Geometry.TabHeaderHeight - Global.Geometry.TabHeaderTextHeight,
                width: UIScreen.mainScreen().bounds.width - (Global.Geometry.TabPanddingLeft + size.width + Global.Geometry.TabPanddingLeft),
                height: Global.Geometry.TabHeaderTextHeight))
            textTaskTitle.addTarget(self, action: "addTapOutsideRecognizer:", forControlEvents: UIControlEvents.TouchDown)
            textTaskTitle.textColor = Global.Color.Title
            textTaskTitle.tintColor = Global.Color.Title
            textTaskTitle.font = Global.Font.Title
            header.addSubview(textTaskTitle)
            
            var headerBottomBorder = UIView(frame: CGRect(x: 0, y: Global.Geometry.TabHeaderHeight-1, width: UIScreen.mainScreen().bounds.size.width, height: 1))
            headerBottomBorder.backgroundColor = Global.Color.TabSeperate
            header.addSubview(headerBottomBorder)
            
            return header		
        }
        return nil
    }
    
    /* table end */
    
    @IBAction func btnStartTouchDownHandler(sender: AnyObject) {
        self.btnStart.backgroundColor = Global.Color.BtnStartHighLightFill
        self.btnStart.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.btnStart.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
    }
    
    @IBAction func btnStartTouchUpOutsideHanlder(sender: AnyObject) {
        self.btnStart.backgroundColor = Global.Color.BtnStartFill
    }
    
    @IBAction func btnStartTouchUpInsideHanlder(sender: AnyObject) {
        self.btnStart.backgroundColor = Global.Color.BtnStartFill
    }
    
    func switchSwitchRestUp(sender: AnyObject)
    {
        var target = sender as UIView
        if let cell = target.superview as? TabCellRestUp {
            cell.switchRestUp.setOn(!cell.switchRestUp.on, animated: true)
        }
    }
    
    func handlePickerTime(sender: UIDatePicker)
    {
        let view = (sender as UIView).superview
        if let cell = view?.superview as? TabCellDeadLine {
            cell.lblTime.text = Global.DateTime.getDiffPeriod(NSDate(), toDate: sender.date)
        }
    }
    
    func switchPickerTime(sender: AnyObject)
    {
        var target = sender as UIView
        if let cell = target.superview as? TabCellDeadLine {
            if cell.picker.hidden {
                cell.picker.hidden = !cell.picker.hidden
                var originPickerHeight = cell.picker.frame.size.height
                cell.picker.frame.size.height = 0
                UIView.animateWithDuration(0.28, delay: 0, options: .CurveEaseOut, animations: {
                    cell.picker.frame.size.height = originPickerHeight;
                    self.btnStart.frame.origin.y = self.btnStart.frame.origin.y + 115
                }, completion: nil)
                cell.lblTime.textColor = Global.Color.EditHighLight
            } else {
                UIView.animateWithDuration(0.28, delay: 0, options: .CurveEaseOut, animations: {
                    cell.picker.frame.size.height = 0
                    self.btnStart.frame.origin.y = self.btnStart.frame.origin.y - 115
                    }, completion: nil)
                cell.lblTime.textColor = Global.Color.Content
                cell.picker.hidden = !cell.picker.hidden
            }
            if !cell.picker.hidden {
                textTaskTitle.resignFirstResponder()
                cell.frame.size.height = 44 + cell.picker.frame.height
            } else {
                cell.frame.size.height = 44
            }
        }
    }
}

