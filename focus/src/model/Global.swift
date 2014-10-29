//
//  Global.swift
//  focus
//
//  Created by Po-Hsiang Huang on 2014/10/25.
//  Copyright (c) 2014年 Po-Hsiang Huang. All rights reserved.
//

import Foundation
import UIKit

struct Global {
    struct Color{
        static let Title:UIColor = UIColor(red: 97/255, green: 93/255, blue: 81/255, alpha: 1)
        static let Content:UIColor = UIColor(red: 97/255, green: 93/255, blue: 81/255, alpha: 1)
        static let TabSeperate:UIColor = UIColor(red: 200/255, green: 199/255, blue: 204/255, alpha: 1)
        static let BtnStartFill:UIColor = UIColor(red: 227/255, green: 224/255, blue: 212/255, alpha: 1)
        static let BtnStartHighLightFill:UIColor = UIColor(red: 95/255, green: 93/255, blue: 81/255, alpha: 1)
        static let SwitchOnTintColor:UIColor = UIColor(red: 187/255, green: 223/255, blue: 115/255, alpha: 1)
        static let EditHighLight:UIColor = UIColor(red: 1, green: 51/255, blue: 0, alpha: 1)
    }
    
    struct Font {
        static let Title:UIFont = UIFont(name: "HelveticaNeue", size: 17)!
        static let Content:UIFont = UIFont(name: "HelveticaNeue-Light", size: 19)!
    }
    
    struct Num {
        static let TabCellOfForm:Int = 2
    }
    
    struct Geometry {
        static let TabHeaderHeight:CGFloat = 70
        static let TabHeaderTextHeight:CGFloat = 40
        static let TabCellHeight:CGFloat = 42.5
        static let TabPanddingLeft:CGFloat = 15
        static let TabPanddingRight:CGFloat = 20
        static let BtnStartRadius:CGFloat = 80
        static func BtnStartCGPath() -> CGPathRef {
            var path = UIBezierPath()
            var center:CGPoint = CGPoint(x: BtnStartRadius, y: BtnStartRadius)
            path.addArcWithCenter(center, radius: BtnStartRadius, startAngle: CGFloat(0), endAngle:CGFloat(M_PI*2), clockwise: true)
            return path.CGPath
        }
    }
    
    struct DateTime {
        static func getDiffPeriod(fromDate:NSDate, toDate:NSDate) ->String {
            var calendar = NSCalendar.currentCalendar()
            var diff:NSDateComponents = calendar.components(NSCalendarUnit.CalendarUnitMinute, fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.MatchFirst)
            var endString = ""
            if diff.minute > 0 {
                endString = "later"
            }else {
                endString = "before"
            }
            var absDiff = abs(Int(diff.minute))
            return "\(_getDiffPeriod(absDiff)) \(endString)"
        }
        
        static func _getDiffPeriod(dateDiff:Int) -> String{
            var minutes = dateDiff
            var hours:Float = 0
            var days:Float = 0
            
            if dateDiff >= 60 {
                hours = ceil(Float(dateDiff)/Float(60))
                minutes = dateDiff % 60
            }
            
            if Float(hours) >= Float(24) {
                days = Float(ceil(Float(hours)/Float(24)))
                hours = Float(hours) % 24
            }
            
            if days == 0 && hours == 0 {
                return "\(Int(minutes)) minutes"
            } else if days == 0 {
                return "\(Int(hours)) hours \(Int(minutes)) minutes"
            } else {
                return "\(Int(days)) days \(Int(hours)) hours"
            }
        }
    }
}