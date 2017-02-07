//
//  DotView.swift
//  DotAnimation
//
//  Created by Tengfei on 2016/11/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    let radius:CGFloat = 5
    let margin:CGFloat = 20
    
    var progress:Int = 0 {
        didSet{
            //注意:drawRect如果是手动调用的话, 它是不会给你创建跟View相关联的上下文.
            //只有系统调用该方法时, 才会创建跟View相关联的上下文.
            //[self drawRect:self.bounds];
            //重绘(系统自动帮你调用drawRect:)
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
//        print("progress--draw:\(progress),--:\(progress % 3)")

        
        let point2 = self.center
        
        // point 1
        let path1 = UIBezierPath()
        let point1 = CGPoint(x: point2.x - margin, y: point2.y)
        path1.addArc(withCenter: point1, radius: radius, startAngle: 0.0, endAngle: 180.0, clockwise: true)
        if progress % 3 == 0 {
             UIColor.white.setFill()
        }else{
            UIColor(colorLiteralRed: 255/255.0, green: 100/255.0, blue: 101/255.0, alpha: 1.0).setFill()
        }
        path1.fill()
        
        // point 2
        let path2 = UIBezierPath()
        path2.addArc(withCenter: point2, radius: radius, startAngle: 0.0, endAngle: 180.0, clockwise: true)
        if progress % 3 == 1 {
            UIColor.white.setFill()
        }else{
            UIColor(colorLiteralRed: 253/255.0, green: 226/255.0, blue: 0/255.0, alpha: 1.0).setFill()
        }
        path2.fill()
        
        // point 3
        let path3 = UIBezierPath()
        let point3 = CGPoint(x: point2.x + margin, y: point2.y)
        path3.addArc(withCenter: point3, radius: radius, startAngle: 0.0, endAngle: 180.0, clockwise: true)
        if progress % 3 == 2 {
            UIColor.white.setFill()
        }else{
            UIColor(colorLiteralRed: 97/255.0, green: 213/255.0, blue: 250/255.0, alpha: 1.0).setFill()
        }
        path3.fill()
    }

}
//        rgb(255, 100, 101)
//        rgb(253, 226, 0)
//        rgb(97, 213, 250)
